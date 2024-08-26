
import mimetypes
import os
import pathlib
from datetime import datetime
from functools import partial
from itertools import chain

from packaging import version as _version

from pelican import signals

import yaml


AUTHOR = "Envoy maintainers <envoy-maintainers@googlegroups.com>"
DEFAULT_LANG = "en"
EXTRA_PATH_METADATA = {
    "assets/robots.txt": {"path": "robots.txt"},
    "assets/favicon.ico": {"path": "favicon.ico"},
    "assets/404": {"path": "404.html"},
    "assets/google7933de1bd04e097b": {"path": "google7933de1bd04e097b.html"},
    "assets/google95e577d28834e13d": {"path": "google95e577d28834e13d.html"},
}

FILENAME_METADATA = r"(?P<title>.*)"
NOW = datetime.now()
PATH = "content"
PLUGINS = [
    "pelican.plugins.webassets"]
SITENAME = "Envoy proxy apt repository"
SITEURL = os.environ.get("SITEURL") or "https://apt.envoyproxy.io"
ENVOYURL = "https://envoyproxy.io"
STATIC_PATHS = [
    "images",
    "assets",
]

DELETE_OUTPUT_DIRECTORY = True
STATIC_PATHS = ["."]
STATIC_EXCLUDES = ["css"]
STATIC_EXCLUDE_SOURCES = True

THEME = "theme"
TIMEZONE = "Europe/London"

for yaml_file in pathlib.Path("data").glob("*.yaml"):
    locals()[yaml_file.stem.upper()] = yaml.safe_load(yaml_file.read_text())

DISTROS = {
    "bookworm": "debian",
    "bullseye": "debian",
    "focal": "ubuntu",
    "jammy": "ubuntu"}

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None
DEFAULT_PAGINATION = False

INDEX_SAVE_AS = 'index.html'

MIME_TO_ICON = {
    'application/pdf': 'fas fa-file-pdf',
    'application/msword': 'fas fa-file-word',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document': 'fas fa-file-word',
    'application/vnd.ms-excel': 'fas fa-file-excel',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet': 'fas fa-file-excel',
    'image/jpeg': 'fas fa-file-image',
    'image/png': 'fas fa-file-image',
    'video/mp4': 'fas fa-file-video',
    'video/x-msvideo': 'fas fa-file-video',
    'audio/mpeg': 'fas fa-file-audio',
    'audio/wav': 'fas fa-file-audio',
    'application/zip': 'fas fa-file-archive',
    'application/x-tar': 'fas fa-file-archive',
    'text/plain': 'fas fa-file-alt',
    'application/octet-stream': 'fas fa-file',
    "application/vnd.debian.binary-package": "debian-icon",
    "application/x-debian-package": "debian-icon",
    "application/pgp-keys": "fa fa-key",
    "application/pgp-signature": "fas fa-file-signature"}

mimetypes.add_type('application/pgp-keys', '.key')
mimetypes.add_type('application/pgp-signature', '.gpg')


class FileTree(object):

    def __init__(self, files):
        self.files = files

    @property
    def mime_to_icon(self):
        return MIME_TO_ICON

    @property
    def directories(self):
        _directories = set()
        for file in self.files:
            parent = str(pathlib.Path(file).parent)
            if parent != ".":
                _directories.add(parent)
        return _directories

    @property
    def as_dict(self):
        directory_structure = dict(dirs={}, files={})

        for dir_path in sorted(self.directories):
            self._add_directory_to_structure(directory_structure["dirs"], dir_path)

        for file_path in sorted(self.files):
            self._add_file_to_structure(directory_structure, file_path)

        return directory_structure

    def _add_directory_to_structure(self, directory_structure, path):
        components = path.lstrip("./").strip("/").split("/")
        current = directory_structure

        for part in components:
            if part not in current:
                current[part] = {"files": {}, "dirs": {}}
            current = current[part]["dirs"]

    def _add_file_to_structure(self, directory_structure, path):
        components = path.lstrip("./").strip("/").split("/")
        current = directory_structure

        if len(components) == 1:
            directory_structure["files"][path] = {"class": self.class_for_file(components[0])}
            return

        for part in components[:-1]:
            current = current["dirs"][part]

        current["files"][components[-1]] = {"class": self.class_for_file(components[-1])}

    def class_for_file(self, filename):
        mimetype, encoding = mimetypes.guess_type(filename)

        if not mimetype and encoding in ["gzip", "bzip2"]:
            return "fas fa-compress"
        return self.mime_to_icon.get(mimetype) or self.mime_to_icon.get("application/octet-stream")


class Indexer(object):

    def __init__(self, callback):
        self.callback = callback

    def walk(self, directory, path=""):
        for dir_name, contents in directory.items():
            current_path = f"{path}/{dir_name}" if path else dir_name
            self.callback(current_path, contents)

            # Recursively walk into subdirectories
            for subdir_name, subdir_contents in contents.get("dirs", {}).items():
                self.walk({subdir_name: subdir_contents}, current_path)


files = ["signing.key"] + pathlib.Path("data/file_list.txt").read_text().splitlines()

DIRECTORY_STRUCTURE = FileTree(files).as_dict


def add_index(template, context, dir_name, contents):
    output_path = pathlib.Path(f"output/{dir_name}/index.html")
    output_path.parent.mkdir(parents=True, exist_ok=True)
    context["listdir"] = contents
    context["cwd"] = dir_name

    with open(output_path, 'w') as f:
        template.stream(context).dump(f)


def generate_directory_indexes(generator):
    Indexer(
        partial(
            add_index,
            generator.get_template("directory"),
            generator.context)).walk(DIRECTORY_STRUCTURE["dirs"])

signals.page_generator_finalized.connect(generate_directory_indexes)
