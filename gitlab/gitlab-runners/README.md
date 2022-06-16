1. Install gitlab runner
2. Register gitlab runner
3. Update gitlab runner

# Install GitLab Runner
GitLab Runner can be installed and used on GNU/Linux, macOS, FreeBSD, and Windows. 

You can install it:
- `By using a repository for rpm/deb packages (Best option)`
- `By installing a package directly (Good enough)`
  - Official packages available for the following Linux distributions: CentOS, Debian, Ubuntu, RHEL, Fedora, Mint
- `By downloading a binary. (Not that good)`
  - officially supported binaries available for the following architectures: x86, AMD64, ARM64, ARM, s390x, ppc64le
- `In a container`.


## Install GitLab Runner from a **repository**
### For Debian/Ubuntu/Mint:
- Install:
  - **Download** the repository script:
      ```
      curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
      ```
  - **Install** the **latest package** version of GitLab Runner
      ```
      sudo apt-get install gitlab-runner version
      ```
  - **OR Install** a **specific package** version of GitLab Runner
      ```
      apt-cache madison gitlab-runner
      sudo apt-get install gitlab-runner=10.0.0
      ```
- Register:
  - **Register** runner
    - Check [register-gitlab-runner](#register-gitlab-runner) section
- Update:
  - **Update** the package
      ```
      sudo apt-get update
      sudo apt-get install gitlab-runner
      ```

### For RHEL/CentOS/Fedora:
- Install:
  - **Download** the repository script
    ```
    curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh" | sudo bash
    ```
  - **Install** the **latest package** version of GitLab Runner
    ```
    sudo yum install gitlab-runner
    ```
  - **Install** a **specific package** version of GitLab Runner
    ```
    yum list gitlab-runner --showduplicates | sort -r
    sudo yum install gitlab-runner-10.0.0-1
    ```
- Register:
  - **Register** runner
    - Check [register-gitlab-runner](#register-gitlab-runner) section
- Update:
  - **Update** the package
    ```
    sudo yum update
    sudo yum install gitlab-runner
    ```

## Install GitLab Runner from a **package**
### For Debian or Ubuntu:
- Install:
  - **Download** the **package**
    ```
    # Replace ${arch} with any of the supported architectures, e.g. amd64, arm, arm64
    # A full list of architectures can be found here https://gitlab-runner-downloads.s3.amazonaws.com/latest/index.html
    curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_${arch}.deb"
    ```
  - **Install** the **package**
    ```
    dpkg -i gitlab-runner_<arch>.deb
    ```
- Register:
  - **Register** runner
    - Check [register-gitlab-runner](#register-gitlab-runner) section
- Update:
  - **Update** the package
    - Download the latest package for your system then upgrade as follows
      ```
      dpkg -i gitlab-runner_<arch>.deb
      ```

### For CentOS or Red Hat Enterprise Linux:
- Install:
  - **Download** the **package**
    ```
    # Replace ${arch} with any of the supported architectures, e.g. amd64, arm, arm64
    # A full list of architectures can be found here https://gitlab-runner-downloads.s3.amazonaws.com/latest/index.html
    curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/rpm/gitlab-runner_${arch}.rpm"
    ```
  - **Install** the **package**
    ```
    rpm -i gitlab-runner_<arch>.rpm
    ```
- Register:
  - **Register** runner
    - Check [register-gitlab-runner](#register-gitlab-runner) section
- Update:
  - **Update** the package
    - Download the latest package for your system then upgrade as follows
      ```
      rpm -Uvh gitlab-runner_<arch>.rpm
      ```

## Install GitLab Runner from a **binary**
If you can’t use the deb/rpm repository to install GitLab Runner, or your GNU/Linux OS is not among the supported ones, you can install it manually using one of the methods below, as a last resort.
- Install:
  - **Download** the **binary**
    ```
    # Linux x86-64
    sudo curl -L --output /usr/local/bin/gitlab-runner "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64"

    # Linux x86
    sudo curl -L --output /usr/local/bin/gitlab-runner "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-386"

    # Linux arm
    sudo curl -L --output /usr/local/bin/gitlab-runner "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-arm"

    # Linux arm64
    sudo curl -L --output /usr/local/bin/gitlab-runner "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-arm64"
    ```
  - Give it **permissions to execute**:
    ```
    sudo chmod +x /usr/local/bin/gitlab-runner
    ```
  - **Create** a GitLab CI **user**: 
    ```
    sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
    ```
  - **Install** and **run as service**:
    ```
    sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
    sudo gitlab-runner start
    ```
- Register:
  - **Register** runner
    - Check [register-gitlab-runner](#register-gitlab-runner) section
- Update:
  - **Update** the package
    - Stop the service
      ```
      sudo gitlab-runner stop
      ```
    - Download the binary to replace the GitLab Runner executable, For example:
      ```
      sudo curl -L --output /usr/local/bin/gitlab-runner "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64"
      ```
    - Give it permissions to execute: 
      ```
      sudo chmod +x /usr/local/bin/gitlab-runner
      ```
    - Start the service:
      ```
      sudo gitlab-runner start
      ```


# Register gitlab runner
  - Registration via **one command with arguments**
      ```
      sudo gitlab-runner register \
        --non-interactive \
        --url "https://gitlab.com/" \
        --registration-token "PROJECT_REGISTRATION_TOKEN" \
        --executor "docker" \
        --docker-image alpine:latest \
        --description "docker-runner" \
        --maintenance-note "Free-form maintainer notes about this runner" \
        --tag-list "docker,aws" \
        --run-untagged="true" \
        --locked="false" \
        --access-level="not_protected"
      ```
  
  - Registration via **configuration template file**:
    - Using --template-config
      ```
      sudo gitlab-runner register --template-config /path/to/config.toml
      ```
    - Using environment variable
      ```
      export TEMPLATE_CONFIG_FILE = /path/to/config.toml
      gitlab-runner register
      ```
