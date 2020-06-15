workspace(name = "asylo_examples")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# Download and use the Asylo SDK.
http_archive(
    name = "com_google_asylo",
    urls = ["https://github.com/google/asylo/archive/v0.3.4.2.tar.gz"],
    strip_prefix = "asylo-0.3.4.2",
    sha256 = "82226be212b9f3e2fb14fdf9223e4f376df89424874ac45faff215fa1027797e",
)

load("@com_google_asylo//asylo/bazel:asylo_deps.bzl", "asylo_go_deps")
asylo_go_deps()

# this must be the same version that tensorflow uses
http_archive(
    name = "io_bazel_rules_closure",
    sha256 = "e0a111000aeed2051f29fcc7a3f83be3ad8c6c93c186e64beb1ad313f0c7f9f9",
    strip_prefix = "rules_closure-cf1e44edb908e9616030cc83d085989b8e6cd6df",
    urls = [
        "http://mirror.tensorflow.org/github.com/bazelbuild/rules_closure/archive/cf1e44edb908e9616030cc83d085989b8e6cd6df.tar.gz",
        "https://github.com/bazelbuild/rules_closure/archive/cf1e44edb908e9616030cc83d085989b8e6cd6df.tar.gz",  # 2019-04-04
        ],
)


load("@io_bazel_rules_closure//closure:defs.bzl", "closure_repositories")

closure_repositories(omit_com_google_protobuf=True)

load("@com_google_asylo//asylo/bazel:asylo_deps.bzl", "asylo_deps",
     "asylo_backend_deps", "asylo_testonly_deps")
asylo_deps()
asylo_backend_deps()
asylo_testonly_deps()


# required by new build
# https://github.com/bazelbuild/bazel-skylib/release
http_archive(
  name = "bazel_skylib",
  sha256 = "1dde365491125a3db70731e25658dfdd3bc5dbdfd11b840b3e987ecf043c7ca0",
  urls = [
    "https://storage.googleapis.com/mirror.tensorflow.org/github.com/bazelbuild/bazel-skylib/releases/download/0.9.0/bazel_skylib-0.9.0.tar.gz",
    "https://github.com/bazelbuild/bazel-skylib/releases/download/0.9.0/bazel_skylib-0.9.0.tar.gz",
  ],
)

http_archive(
    name = "org_tensorflow",
    urls = ["https://github.com/tensorflow/tensorflow/archive/v1.14.0.tar.gz"],
    strip_prefix = "tensorflow-1.14.0",
    sha256 = "aa2a6a1daafa3af66807cfe0bc77bfe1144a9a53df9a96bab52e3e575b3047ed",
    patches = ["lite.patch"],
    patch_args = ["-p1"]
)

load("@org_tensorflow//tensorflow:workspace.bzl", "tf_workspace")

tf_workspace()

load("@com_google_asylo//asylo/bazel:sgx_deps.bzl", "sgx_deps")
sgx_deps()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")
grpc_deps()
