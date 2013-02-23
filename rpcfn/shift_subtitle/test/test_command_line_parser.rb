require 'minitest/autorun'
require 'optparse'
require_relative '../lib/shift_subtitle'

class TestCommandLineParser < MiniTest::Unit::TestCase
  def setup
    @cmd_parser = ShiftSubtitle::CommandLineParser.new
  end

  def teardown
    @cmd_parser = nil
  end

  def test_missing_operation_option
    begin
      @cmd_parser.parse(["-t", "33,333", "a", "b"], true)
    rescue OptionParser::ParseError => e
      assert(OptionParser::AmbiguousOption < OptionParser::ParseError, "Wrong exception type")
      assert_equal("ambiguous option: Wrong number of options", e.message, "Wrong exception message")
    end
  end

  def test_missing_operation_option_no_exception
    begin
      @cmd_parser.parse(["-t", "33,333", "a", "b"])
    rescue OptionParser::ParseError
      refute(true, "Shouldn't have come to the rescue block")
    end
  end

  def test_wrong_operation_option_short_style
    begin
      @cmd_parser.parse(["-o", "no_such_op", "-t", "33,333", "a", "b"], true)
    rescue OptionParser::ParseError => e
      assert(OptionParser::InvalidArgument < OptionParser::ParseError, "Wrong exception type")
      assert_equal("invalid argument: -o no_such_op", e.message, "Wrong exception message")
    end
  end

  def test_wrong_operation_option_long_style
    begin
      @cmd_parser.parse(["--operation", "no_such_op", "-t", "33,333", "a", "b"], true)
    rescue OptionParser::ParseError => e
      assert(OptionParser::InvalidArgument < OptionParser::ParseError, "Wrong exception type")
      assert_equal("invalid argument: --operation no_such_op", e.message, "Wrong exception message")
    end
  end

  def test_missing_time_option
    begin
      @cmd_parser.parse(["-o", "add", "a", "b"], true)
    rescue OptionParser::ParseError => e
      assert(OptionParser::AmbiguousOption < OptionParser::ParseError, "Wrong exception type")
      assert_equal("ambiguous option: Wrong number of options", e.message, "Wrong exception message")
    end
  end

  def test_missing_time_option_no_exception
    begin
      @cmd_parser.parse(["-o", "add", "a", "b"], false)
    rescue OptionParser::ParseError => e
      assert(OptionParser::AmbiguousOption < OptionParser::ParseError, "Wrong exception type")
      assert_equal("ambiguous option: Wrong number of options", e.message, "Wrong exception message")
    end
  end

  def test_wrong_time_option_short_style
    begin
      @cmd_parser.parse(["-o", "add", "-t", "no_such_time", "a", "b"], true)
    rescue OptionParser::ParseError => e
      assert(OptionParser::InvalidArgument < OptionParser::ParseError, "Wrong exception type")
      assert_equal("invalid argument: -t no_such_time", e.message, "Wrong exception message")
    end
  end

  def test_wrong_time_option_long_style
    begin
      @cmd_parser.parse(["-o", "add", "--time", "no_such_time", "a", "b"], true)
    rescue OptionParser::ParseError => e
      assert(OptionParser::InvalidArgument < OptionParser::ParseError, "Wrong exception type")
      assert_equal("invalid argument: --time no_such_time", e.message, "Wrong exception message")
    end
  end

  def test_missing_operation_and_time_options
    begin
      @cmd_parser.parse(["a", "b"], true)
    rescue OptionParser::ParseError => e
      assert(OptionParser::AmbiguousOption < OptionParser::ParseError, "Wrong exception type")
      assert_equal("ambiguous option: Wrong number of options", e.message, "Wrong exception message")
    end
  end

  def test_missing_operation_option_and_output_file_argument
    begin
      @cmd_parser.parse(["--time", "33,333", "a"], true)
    rescue OptionParser::ParseError => e
      assert(OptionParser::AmbiguousOption < OptionParser::ParseError, "Wrong exception type")
      assert_equal("ambiguous option: Wrong number of options", e.message, "Wrong exception message")
    end
  end

  def test_too_many_arguments
    begin
      @cmd_parser.parse(["-o", "add", "--time", "33,333", "a", "b", "c"], true)
    rescue OptionParser::ParseError => e
      assert(OptionParser::InvalidArgument < OptionParser::ParseError, "Wrong exception type")
      assert_equal("ambiguous argument: Wrong number of arguments", e.message, "Wrong exception message")
    end
  end

  def test_operation
    @cmd_parser.parse(["-o", "add", "--time", "33,333", "a", "b"], true)
    assert_equal("add", @cmd_parser.operation(), "Wrong operation")
  end

  def test_time
    @cmd_parser.parse(["-o", "add", "--time", "33,333", "a", "b"], true)
    assert_equal("33,333", @cmd_parser.time(), "Wrong time")
  end

  def test_input_file
    @cmd_parser.parse(["-o", "add", "--time", "33,333", "a", "b"], true)
    assert_equal("a", @cmd_parser.input_file(), "Wrong input file")
  end

  def test_output_file
    @cmd_parser.parse(["-o", "add", "--time", "33,333", "a", "b"], true)
    assert_equal("b", @cmd_parser.output_file(), "Wrong output file")
  end
end