# This file makes it possible to install RubyCAS-Client as a Rails plugin.

$: << File.expand_path(File.dirname(__FILE__))+'/../../lib'
$: << File.expand_path(File.dirname(__FILE__))+'/../../../ruby-fabulator/lib'

require 'fabulator'
require 'fabulator/xml'
require 'spec/expectations'
