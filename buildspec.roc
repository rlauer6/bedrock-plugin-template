<null:module      ($input.module --or 'MyPlugin') >
<null:github_user ($input.github_user --or 'rlauer6') >
<null:email       ($input.email --or 'anonymouse@example.org') >
<null:author      ($input.author --or 'anonymouse') >

<null:module_name $module.format('BLM::Startup::%s')>

<null:short_name --lc $module>

<null:config_name $short_name.format('%s.xml') >

<sink:buildspec ->
project:
  description: <var $module_name>
  author:
    name: <var $author>
    mailto: <var $email>
pm_module: <var $module_name>
min-perl-version: 5.010
dependencies:
  requires: requires
  test_requires: test-requires
path:
  pm_module: lib
  tests: t
extra-files:
  - ChangeLog
  - share:
      - share/<var $config_name>
resources:
  homepage: http://github.com/<var $github_user>/bedrock-plugin-<var $short_name>.git
  bugtracker:
    web: http://github.com/<var $github_user>/bedrock-plugin-<var $short_name>/issues
    mailto: <var $email>
  repository:
    url: git://github.com/<var $github_user>/bedrock-plugin-<var $short_name>.git
    web: http://github.com/<var $github_user>/bedrock-plugin.<var $short_name>
    type: 'git'
</sink><var --flush $buildspec>
