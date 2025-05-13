# Overview

This project contains a single script (`create-plugin-project.sh`)
that you use to layout your Bedrock plugin project. If you don't know
about Bedrock plugins and you've installed Bedrock or are using one of
the [Bedrock images]() you can learn about plugins by reading the
docs.

```
perldoc Bedrock::Application::Plugin
```

The script creates a new Bedrock plugin from a template and the scaffolding that allows
you to create a CPAN distribution for deploying your plugin.

# Prerequisites

* `Bedrock`
* `CPAN::Maker`
* `Module::ScanDeps::Static`

You can install Bedrock from the offical Bedrock CPAN repository.

```
export PERL_CPANM_OPT="--mirror-only --mirror https://cpan.openbedrock.net/orepan2 --mirror https://cpan.metacpan.org"
```

# Quickstart

```
curl -L -o project.zip https://github.com/rlauer6/bedrock-plugin-template/archive/refs/heads/main.zip
unzip project.zip
mv bedrock-plugin-template-main MyPlugin
cd MyPlugin
./create-plugin-project.sh -m MyPlugin 
```

After running this command you'll have a project that looks like this:

```
.
├── 00-test.roc
├── bin
├── buildspec.roc
├── buildspec.yml
├── ChangeLog
├── create-plugin-project.sh
├── lib
│   └── BLM
│       └── Startup
│           └── MyPlugin.pm
├── Makefile
├── Makefile.roc
├── myplugin.roc
├── README.md
├── share
│   └── myplugin.xml
├── t
│   └── 00-myplugin.t
├── test-myplugin.pl
└── test-plugin.roc
```

# Next Steps

1. Run `make clean` to remove the script and other artifacts not needed in your project
2. Test the build
   ```
   make cpan
   ```
3. Run `git init` to initialize a git project
4. Start developing your plugin




