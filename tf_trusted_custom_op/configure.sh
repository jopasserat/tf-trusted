#!/bin/bash
# Copyright 2018 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================
TF_REQUIRED_VERSION=1.14.0

function write_to_bazelrc() {
  echo "$1" >> .bazelrc
}

function write_action_env_to_bazelrc() {
  write_to_bazelrc "build --action_env $1=\"$2\""
}

rm .bazelrc
if python -c "import tensorflow" &> /dev/null; then
    CURR_VERSION=( $(python -c "import tensorflow; print(tensorflow.__version__)") )
    if [ "$CURR_VERSION" != "$TF_REQUIRED_VERSION" ]; then
        echo "TF Trusted currently only supports Tensorflow version $TF_REQUIRED_VERSION you have $CURR_VERSION"
        echo "Please install Tensorflow version $TF_REQUIRED_VERSION"
        exit
    fi
    echo 'using installed tensorflow'
else
    pip install tensorflow==1.14.0
fi

TF_CFLAGS=( $(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_compile_flags()))') )
TF_LFLAGS=( $(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_link_flags()))') )

write_action_env_to_bazelrc "TF_HEADER_DIR" ${TF_CFLAGS:2}
write_action_env_to_bazelrc "TF_SHARED_LIBRARY_DIR" ${TF_LFLAGS:2}
