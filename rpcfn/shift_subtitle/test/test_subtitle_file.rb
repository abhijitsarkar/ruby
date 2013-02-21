require 'minitest/autorun'
require 'shift_subtitle'

class TestSubtitleFile < MiniTest::Unit::TestCase
  def setup
    @subtitle_file = ShiftSubtitle::SubtitleFile.new("/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test/test_subtitle.srt",
    "/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test/test_subtitle_shifted.srt")
  end

  def teardown
    @subtitle_file = nil
  end

  def test_read_invalid_input_file
    begin
      ShiftSubtitle::SubtitleFile.new("/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test/junk_subtitle.srt",
      "/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test/test_subtitle_shifted.srt")
      refute(true, "Shouldn't have come here, should've failed to open the file")
    rescue Errno::ENOENT => e
      puts "test_read_invalid_input_file [ERROR]: " + e.message
      assert(true, "Good thing that it failed while trying to open a nonexistent file")
    end
  end

  def test_read_valid_input_file
    begin
      refute_nil(@subtitle_file, "Subtitle file shouldn't be nil")
      @subtitle_file.shift("add", "33,333")
    rescue Exception => e
      puts "test_read_valid_input_file [ERROR]: " + e.message
      refute(true, "Shouldn't have come to the rescue block")
    end
  end

  #
  #  def test_positive_timeshift
  #    subtitle_file = SubtitleFile.new("/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle.srt",
  #    "/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle_shifted.srt")
  #    assert_equal("01:31:05,710", subtitle_file.shift_internal("01", "31", "5", "210", "00", "500"), "Wrong timeshift")
  #  end
  #
  #  def test_positive_timeshift_with_milliseconds_rollover
  #    subtitle_file = SubtitleFile.new("/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle.srt",
  #    "/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle_shifted.srt")
  #    assert_equal("01:31:06,110", subtitle_file.shift_internal("01", "31", "5", "610", "00", "500"), "Wrong timeshift")
  #  end
  #
  #  def test_positive_timeshift_with_milliseconds_and_seconds_rollover
  #    subtitle_file = SubtitleFile.new("/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle.srt",
  #    "/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle_shifted.srt")
  #    assert_equal("01:31:07,110", subtitle_file.shift_internal("01", "31", "5", "610", "1", "500"), "Wrong timeshift")
  #  end
  #
  #  def test_positive_timeshift_with_milliseconds_seconds_and_minutes_rollover
  #    subtitle_file = SubtitleFile.new("/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle.srt",
  #    "/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle_shifted.srt")
  #    assert_equal("01:32:05,998", subtitle_file.shift_internal("01", "31", "5", "999", "59", "999"), "Wrong timeshift")
  #  end
  #
  #  def test_positive_timeshift_with_milliseconds_seconds_minutes_and_hours_rollover
  #    subtitle_file = SubtitleFile.new("/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle.srt",
  #    "/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle_shifted.srt")
  #    assert_equal("02:00:59,998", subtitle_file.shift_internal("01", "59", "59", "999", "59", "999"), "Wrong timeshift")
  #  end
  #
  #  def test_negative_timeshift
  #    subtitle_file = SubtitleFile.new("/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle.srt",
  #    "/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle_shifted.srt")
  #    assert_equal("01:31:05,210", subtitle_file.shift_internal("01", "31", "5", "710", "-00", "500"), "Wrong timeshift")
  #  end
  #
  #  def test_negative_timeshift_with_milliseconds_rollover
  #    subtitle_file = SubtitleFile.new("/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle.srt",
  #    "/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle_shifted.srt")
  #    assert_equal("01:31:04,710", subtitle_file.shift_internal("01", "31", "5", "210", "-00", "500"), "Wrong timeshift")
  #  end
  #
  #  def test_negative_timeshift_with_milliseconds_and_seconds_rollover
  #    subtitle_file = SubtitleFile.new("/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle.srt",
  #    "/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle_shifted.srt")
  #    assert_equal("01:31:03,710", subtitle_file.shift_internal("01", "31", "5", "210", "-1", "500"), "Wrong timeshift")
  #  end
  #
  #  def test_negative_timeshift_with_milliseconds_seconds_and_minutes_rollover
  #    subtitle_file = SubtitleFile.new("/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle.srt",
  #    "/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle_shifted.srt")
  #    assert_equal("01:30:05,211", subtitle_file.shift_internal("01", "31", "5", "210", "-59", "999"), "Wrong timeshift")
  #  end
  #
  #  def test_negative_timeshift_with_milliseconds_seconds_minutes_and_hours_rollover
  #    subtitle_file = SubtitleFile.new("/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle.srt",
  #    "/Users/Abhijit/Workspace/eclipse/ruby/rpcfn/shift_subtitle/test_subtitle_shifted.srt")
  #    assert_equal("01:59:00,000", subtitle_file.shift_internal("01", "59", "59", "999", "-59", "999"), "Wrong timeshift")
  #  end

end