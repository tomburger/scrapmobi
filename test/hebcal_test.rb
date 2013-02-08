require 'test_helper'
require 'date'

$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'dvarmobi/hebcal.rb'

class HebCalTest < Test::Unit::TestCase
  
  JANUARY = <<-JAN_REST
{
    "title": "Hebcal January 2013",
    "link": "http://www.hebcal.com/hebcal/?v=1;year=2013;month=1;s=on;i=off;c=off",
    "date": "2013-02-08T21:34:20-00:00",
    "items": [
        {
            "title": "Parashat Shemot",
            "category": "parashat",
            "date": "2013-01-05",
            "link": "http://www.hebcal.com/sedrot/shemot",
            "hebrew": "???? ????"
        },
        {
            "title": "Parashat Vaera",
            "category": "parashat",
            "date": "2013-01-12",
            "link": "http://www.hebcal.com/sedrot/vaera",
            "hebrew": "???? ????"
        },
        {
            "title": "Parashat Bo",
            "category": "parashat",
            "date": "2013-01-19",
            "link": "http://www.hebcal.com/sedrot/bo",
            "hebrew": "???? ??"
        },
        {
            "title": "Parashat Beshalach",
            "category": "parashat",
            "date": "2013-01-26",
            "link": "http://www.hebcal.com/sedrot/beshalach",
            "hebrew": "???? ????"
        }
    ]
}
JAN_REST
  FEBRUARY = <<-FEB_REST
{
    "title": "Hebcal February 2013",
    "link": "http://www.hebcal.com/hebcal/?v=1;year=2013;month=2;s=on;i=off;c=off",
    "date": "2013-02-08T21:35:33-00:00",
    "items": [
        {
            "title": "Parashat Yitro",
            "category": "parashat",
            "date": "2013-02-02",
            "link": "http://www.hebcal.com/sedrot/yitro",
            "hebrew": "???? ????"
        },
        {
            "title": "Parashat Mishpatim",
            "category": "parashat",
            "date": "2013-02-09",
            "link": "http://www.hebcal.com/sedrot/mishpatim",
            "hebrew": "???? ??????"
        },
        {
            "title": "Parashat Terumah",
            "category": "parashat",
            "date": "2013-02-16",
            "link": "http://www.hebcal.com/sedrot/terumah",
            "hebrew": "???? ?????"
        },
        {
            "title": "Parashat Tetzaveh",
            "category": "parashat",
            "date": "2013-02-23",
            "link": "http://www.hebcal.com/sedrot/tetzaveh",
            "hebrew": "???? ????"
        }
    ]
}  
FEB_REST

  def setup
    HebCal.stubs(:service_call).with(1,2013).returns(JANUARY)
    HebCal.stubs(:service_call).with(2,2013).returns(FEBRUARY)
  end

  def teardown
  end

  def test_beshalach_jan_2013
    assert_equal 'beshalach', HebCal.current_parasha(Date.parse('2013-01-24'))
  end
  def test_yitro_feb_2013
    assert_equal 'yitro', HebCal.current_parasha(Date.parse('2013-02-01'))
  end
  def test_yitro_jan_2013
    assert_equal 'yitro', HebCal.current_parasha(Date.parse('2013-01-31'))
  end
  def test_mishpatim_feb_2013
    assert_equal 'mishpatim', HebCal.current_parasha(Date.parse('2013-02-05'))
  end
end
