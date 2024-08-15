load("@bazel_gazelle//:deps.bzl", "go_repository")

def aptly_dependencies():
    go_repository(
        name = "aptly",
        importpath = "github.com/aptly-dev/aptly",
        sha256 = "07e18ce606feb8c86a1f79f7f5dd724079ac27196faa61a2cefa5b599bbb5bb1",
        strip_prefix = "aptly-1.5.0",
        urls = ["https://github.com/aptly-dev/aptly/archive/refs/tags/v1.5.0.tar.gz"],
    )
    go_repository(
        name = "com_github_google_uuid",
        importpath = "github.com/google/uuid",
        sum = "h1:KjJaJ9iWZ3jOFZIf1Lqf4laDRCasjl0BCmnEGxkdLb4=",
        version = "v1.3.1",
    )
    go_repository(
        name = "com_github_azure_azure_pipeline_go",
        importpath = "github.com/Azure/azure-pipeline-go",
        sum = "h1:7U9HBg1JFK3jHl5qmo4CTZKFTVgMwdFHMVtCdfBE21U=",
        version = "v0.2.3",
    )
    go_repository(
        name = "com_github_golang_snappy",
        importpath = "github.com/golang/snappy",
        sum = "h1:yAGX7huGHXlcLOEtBnF4w7FQwA26wojNCwOYAEhLjQM=",
        version = "v0.0.4",
    )
    go_repository(
        name = "com_github_mattn_go_ieproxy",
        importpath = "github.com/mattn/go-ieproxy",
        sum = "h1:MQ/5BuGSgDAHZOJe6YY80IF2UVCfGkwfo6AeD7HtHYo=",
        version = "v0.0.11",
    )
    go_repository(
        name = "com_github_prometheus_client_golang",
        importpath = "github.com/prometheus/client_golang",
        sum = "h1:yk/hx9hDbrGHovbci4BY+pRMfSuuat626eFsHb7tmT8=",
        version = "v1.16.0",
    )
    go_repository(
        name = "com_github_prometheus_common",
        importpath = "github.com/prometheus/common",
        sum = "h1:+5BrQJwiBB9xsMygAB3TNvpQKOwlkc25LbISbrdOOfY=",
        version = "v0.44.0",
    )
    go_repository(
        name = "com_github_gin_contrib_sse",
        importpath = "github.com/gin-contrib/sse",
        sum = "h1:Y/yl/+YNO8GZSjAhjMsSuLt29uWRFHdHYUb5lYOV9qE=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_prometheus_procfs",
        importpath = "github.com/prometheus/procfs",
        sum = "h1:xRC8Iq1yyca5ypa9n1EZnWZkt7dwcoRPQwX/5gwaUuI=",
        version = "v0.11.1",
    )
    go_repository(
        name = "com_github_beorn7_perks",
        importpath = "github.com/beorn7/perks",
        sum = "h1:VlbKKnNfV8bJzeqoa4cOKqO6bYr3WgKZxO8Z16+hsOM=",
        version = "v1.0.1",
    )
    go_repository(
        name = "com_github_cespare_xxhash_v2",
        importpath = "github.com/cespare/xxhash/v2",
        sum = "h1:DC2CZ1Ep5Y4k3ZQ899DldepgrayRUGE6BBZ/cd9Cj44=",
        version = "v2.2.0",
    )
    go_repository(
        name = "com_github_matttproud_golang_protobuf_extensions",
        importpath = "github.com/matttproud/golang_protobuf_extensions",
        sum = "h1:mmDVorXM7PCGKw94cs5zkfA9PSy5pEvNWRP0ET0TIVo=",
        version = "v1.0.4",
    )
    go_repository(
        name = "in_gopkg_yaml_v2",
        importpath = "gopkg.in/yaml.v2",
        sum = "h1:D8xgwECY7CYvx+Y2n4sBz93Jn9JRvxdiyyo8CTfuKaY=",
        version = "v2.4.0",
    )
    go_repository(
        name = "com_github_go_playground_universal_translator",
        importpath = "github.com/go-playground/universal-translator",
        sum = "h1:Bcnm0ZwsGyWbCzImXv+pAJnYK9S473LQFuzCbDbfSFY=",
        version = "v0.18.1",
    )
    go_repository(
        name = "com_github_leodido_go_urn",
        importpath = "github.com/leodido/go-urn",
        sum = "h1:XlAE/cm/ms7TE/VMVoduSpNBoyc2dOxHs5MZSwAN63Q=",
        version = "v1.2.4",
    )
    go_repository(
        name = "com_github_go_playground_locales",
        importpath = "github.com/go-playground/locales",
        sum = "h1:EWaQ/wswjilfKLTECiXz7Rh+3BjFhfDFKv/oXslEjJA=",
        version = "v0.14.1",
    )
    go_repository(
        name = "com_github_jmespath_go_jmespath",
        importpath = "github.com/jmespath/go-jmespath",
        sum = "h1:BEgLn5cpjn8UN1mAw4NjwDrS35OdebyEtFe+9YPoQUg=",
        version = "v0.4.0",
    )
    go_repository(
        name = "com_github_prometheus_client_model",
        importpath = "github.com/prometheus/client_model",
        sum = "h1:5lQXD3cAg1OXBf4Wq03gTrXHeaV0TQvGfUooCfx1yqY=",
        version = "v0.4.0",
    )


def go_dependencies():
    go_repository(
        name = "com_github_aleksi_pointer",
        importpath = "github.com/AlekSi/pointer",
        sum = "h1:KWCWzsvFxNLcmM5XmiqHsGTTsuwZMsLFwWF9Y+//bNE=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_awalterschulze_gographviz",
        importpath = "github.com/awalterschulze/gographviz",
        sum = "h1:24jix3mqu421BBMWbVBOl5pDw0f9ncazW10kaMywzHQ=",
        version = "v0.0.0-20160912181450-761fd5fbb34e",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go",
        importpath = "github.com/aws/aws-sdk-go",
        sum = "h1:MyXUdCesJLBvSSKYcaKeeEwxNUwUpG6/uqVYeH/Zzfo=",
        version = "v1.25.0",
    )
    go_repository(
        name = "com_github_azure_azure_storage_blob_go",
        importpath = "github.com/Azure/azure-storage-blob-go",
        sum = "h1:rXtgp8tN1p29GvpGgfJetavIG0V7OgcSXPpwp3tx6qk=",
        version = "v0.15.0",
    )
    go_repository(
        name = "com_github_cavaliergopher_grab_v3",
        importpath = "github.com/cavaliergopher/grab/v3",
        sum = "h1:4z7TkBfmPjmLAAmkkAZNX/6QJ1nNFdv3SdIHXju0Fr4=",
        version = "v3.0.1",
    )
    go_repository(
        name = "com_github_cheggaaa_pb",
        importpath = "github.com/cheggaaa/pb",
        sum = "h1:CNg2511WECXZ7Ja6jjyz9CMBpQOrMuP5+H5zfjgVi/Q=",
        version = "v1.0.10",
    )
    go_repository(
        name = "com_github_disposaboy_jsonconfigreader",
        importpath = "github.com/DisposaBoy/JsonConfigReader",
        sum = "h1:rv5qJCfIzQhhefHp8MO98hoGRI3mdps2iiGA3o4nm8A=",
        version = "v0.0.0-20130112093355-33a99fdf1d5e",
    )
    go_repository(
        name = "com_github_fatih_color",
        importpath = "github.com/fatih/color",
        sum = "h1:DkWD4oS2D8LGGgTQ6IvwJJXSL5Vp2ffcQg58nFV38Ys=",
        version = "v1.7.0",
    )
    go_repository(
        name = "com_github_gin_gonic_gin",
        importpath = "github.com/gin-gonic/gin",
        sum = "h1:3DoBmSbJbZAWqXJC3SLjAPfutPJJRN1U5pALB7EeTTs=",
        version = "v1.7.7",
    )
    go_repository(
        name = "com_github_go_playground_validator_v10",
        importpath = "github.com/go-playground/validator/v10",
        sum = "h1:uA0+amWMiglNZKZ9FJRKUAe9U3RX91eVn1JYXMWt7ig=",
        version = "v10.10.1",
    )
    go_repository(
        name = "com_github_h2non_filetype",
        importpath = "github.com/h2non/filetype",
        sum = "h1:Esu2EFM5vrzNynnGQpj0nxhCkzVQh2HRY7AXUh/dyJM=",
        version = "v1.0.5",
    )
    go_repository(
        name = "com_github_jlaffaye_ftp",
        importpath = "github.com/jlaffaye/ftp",
        sum = "h1:lWFup/SOhwcpvRJIFqx/WQis5U4SrOSyWfSqvfdF09w=",
        version = "v0.0.0-20180404123514-2403248fa8cc",
    )
    go_repository(
        name = "com_github_kjk_lzma",
        importpath = "github.com/kjk/lzma",
        sum = "h1:RnWZeH8N8KXfbwMTex/KKMYMj0FJRCF6tQubUuQ02GM=",
        version = "v0.0.0-20161016003348-3fd93898850d",
    )
    go_repository(
        name = "com_github_klauspost_compress",
        importpath = "github.com/klauspost/compress",
        sum = "h1:P76CopJELS0TiO2mebmnzgWaajssP/EszplttgQxcgc=",
        version = "v1.13.6",
    )
    go_repository(
        name = "com_github_klauspost_pgzip",
        importpath = "github.com/klauspost/pgzip",
        sum = "h1:qnWYvvKqedOF2ulHpMG72XQol4ILEJ8k2wwRl/Km8oE=",
        version = "v1.2.5",
    )
    go_repository(
        name = "com_github_mattn_go_colorable",
        importpath = "github.com/mattn/go-colorable",
        sum = "h1:/bC9yWikZXAL9uJdulbSfyVNIR3n3trXl+v8+1sx8mU=",
        version = "v0.1.2",
    )
    go_repository(
        name = "com_github_mattn_go_isatty",
        importpath = "github.com/mattn/go-isatty",
        sum = "h1:yVuAays6BHfxijgZPzw+3Zlu5yQgKGP2/hcQbHb7S9Y=",
        version = "v0.0.14",
    )
    go_repository(
        name = "com_github_mattn_go_runewidth",
        importpath = "github.com/mattn/go-runewidth",
        sum = "h1:UnlwIPBGaTZfPQ6T1IGzPI0EkYAQmT9fAEJ/poFC63o=",
        version = "v0.0.2",
    )
    go_repository(
        name = "com_github_mattn_go_shellwords",
        importpath = "github.com/mattn/go-shellwords",
        sum = "h1:5FJ7APbaUYdUTxxP/XXltfy/mICrGqugUEClfnj+D3Y=",
        version = "v1.0.2",
    )
    go_repository(
        name = "com_github_mkrautz_goar",
        importpath = "github.com/mkrautz/goar",
        sum = "h1:Iu5QFXIMK/YrHJ0NgUnK0rqYTTyb0ldt/rqNenAj39U=",
        version = "v0.0.0-20150919110319-282caa8bd9da",
    )
    go_repository(
        name = "com_github_mxk_go_flowrate",
        importpath = "github.com/mxk/go-flowrate",
        sum = "h1:y5//uYreIhSUg3J1GEMiLbxo1LJaP8RfCpH6pymGZus=",
        version = "v0.0.0-20140419014527-cca7078d478f",
    )
    go_repository(
        name = "com_github_ncw_swift",
        importpath = "github.com/ncw/swift",
        sum = "h1:CrRYmUc+mFGIvBiS5JIA4sIdURfDpJ4CGmpmR9mQAZ0=",
        version = "v1.0.30",
    )
    go_repository(
        name = "com_github_pborman_uuid",
        importpath = "github.com/pborman/uuid",
        sum = "h1:9J0mOv1rXIBlRjQCiAGyx9C3dZZh5uIa3HU0oTV8v1E=",
        version = "v0.0.0-20180122190007-c65b2f87fee3",
    )
    go_repository(
        name = "com_github_pkg_errors",
        importpath = "github.com/pkg/errors",
        sum = "h1:FEBLx1zS214owpjy7qsBeixbURkuhQAwrK5UwLGTwt4=",
        version = "v0.9.1",
    )
    go_repository(
        name = "com_github_prometheus_client_golang",
        importpath = "github.com/prometheus/client_golang",
        sum = "h1:ZiaPsmm9uiBeaSMRznKsCDNtPCS0T3JVDGF+06gjBzk=",
        version = "v1.12.1",
    )
    go_repository(
        name = "com_github_smartystreets_gunit",
        importpath = "github.com/smartystreets/gunit",
        sum = "h1:tpTjnuH7MLlqhoD21vRoMZbMIi5GmBsAJDFyF67GhZA=",
        version = "v1.0.4",
    )
    go_repository(
        name = "com_github_smira_commander",
        importpath = "github.com/smira/commander",
        sum = "h1:jLFwP6SDEUHmb6QSu5n2FHseWzMio1ou1FV9p7W6p7I=",
        version = "v0.0.0-20140515201010-f408b00e68d5",
    )
    go_repository(
        name = "com_github_smira_flag",
        importpath = "github.com/smira/flag",
        sum = "h1:OM075OkN4x9IB1mbzkzaKaJjFxx8Mfss8Z3E1LHwawQ=",
        version = "v0.0.0-20170926215700-695ea5e84e76",
    )
    go_repository(
        name = "com_github_smira_go_aws_auth",
        importpath = "github.com/smira/go-aws-auth",
        sum = "h1:VPv+J50mFyP42/GzYhGuT4MJK8w/dlLt4jkoO5yhJRs=",
        version = "v0.0.0-20180731211914-8b73995fd8d1",
    )
    go_repository(
        name = "com_github_smira_go_ftp_protocol",
        importpath = "github.com/smira/go-ftp-protocol",
        sum = "h1:rvtR4+9N2LWPo0UHe6/aHvWpqD9Dhf10P2bfGFht74g=",
        version = "v0.0.0-20140829150050-066b75c2b70d",
    )
    go_repository(
        name = "com_github_smira_go_xz",
        importpath = "github.com/smira/go-xz",
        sum = "h1:tne8XW3soRDJn4DIiqBc4jw+DPashtFMTSC9G0pC3ug=",
        version = "v0.0.0-20150414201226-0c531f070014",
    )
    go_repository(
        name = "com_github_syndtr_goleveldb",
        importpath = "github.com/syndtr/goleveldb",
        sum = "h1:gZZadD8H+fF+n9CmNhYL1Y0dJB+kLOmKd7FbPJLeGHs=",
        version = "v1.0.1-0.20190923125748-758128399b1d",
    )
    go_repository(
        name = "com_github_ugorji_go_codec",
        importpath = "github.com/ugorji/go/codec",
        sum = "h1:YPXUKf7fYbp/y8xloBqZOw2qaVggbfwMlI8WM3wZUJ0=",
        version = "v1.2.7",
    )
    go_repository(
        name = "com_github_wsxiaoys_terminal",
        importpath = "github.com/wsxiaoys/terminal",
        sum = "h1:3UeQBvD0TFrlVjOeLOBz+CPAI8dnbqNSVwUwRrkp7vQ=",
        version = "v0.0.0-20160513160801-0940f3fc43a0",
    )
    go_repository(
        name = "in_gopkg_check_v1",
        importpath = "gopkg.in/check.v1",
        sum = "h1:Hei/4ADfdWqJk1ZMxUNpqntNwaWcugrBjAiHlqqRiVk=",
        version = "v1.0.0-20201130134442-10cb98267c6c",
    )
    go_repository(
        name = "in_gopkg_cheggaaa_pb_v1",
        importpath = "gopkg.in/cheggaaa/pb.v1",
        sum = "h1:n1tBJnnK2r7g9OW2btFH91V92STTUevLXYFb8gy9EMk=",
        version = "v1.0.28",
    )
    go_repository(
        name = "in_gopkg_h2non_filetype_v1",
        importpath = "gopkg.in/h2non/filetype.v1",
        sum = "h1:JMZLYHwIsvWGh+6UcU//eA1aiM8g4SaZm3lJweIR5Ew=",
        version = "v1.0.1",
    )
    go_repository(
        name = "org_golang_google_protobuf",
        importpath = "google.golang.org/protobuf",
        sum = "h1:w43yiav+6bVFTBQFZX0r7ipe9JQ1QsbMgHwbBziscLw=",
        version = "v1.28.0",
    )
    go_repository(
        name = "org_golang_x_crypto",
        importpath = "golang.org/x/crypto",
        sum = "h1:tkVvjkPTB7pnW3jnid7kNyAMPVWllTNOf/qKDze4p9o=",
        version = "v0.0.0-20220331220935-ae2d96664a29",
    )
    go_repository(
        name = "org_golang_x_sys",
        importpath = "golang.org/x/sys",
        sum = "h1:D1v9ucDTYBtbz5vNuBbAhIMAGhQhJ6Ym5ah3maMVNX4=",
        version = "v0.0.0-20220405052023-b1e9470b6e64",
    )
    go_repository(
        name = "org_golang_x_term",
        importpath = "golang.org/x/term",
        sum = "h1:v+OssWQX+hTHEmOBgwxdZxK4zHq3yOs8F9J7mk0PY8E=",
        version = "v0.0.0-20201126162022-7de9c90e9dd1",
    )
    go_repository(
        name = "org_golang_x_time",
        importpath = "golang.org/x/time",
        sum = "h1:GZokNIeuVkl3aZHJchRrr13WCsols02MLUcz1U9is6M=",
        version = "v0.0.0-20211116232009-f0f3c7e86c11",
    )
