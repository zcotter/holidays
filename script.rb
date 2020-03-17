require "bundler/setup"
require "holidays"
require 'memory_profiler'
require 'holidays/core_extensions/date'
require 'pry'
class Date
  include Holidays::CoreExtensions::Date

  def federal_reserve_holiday?
    holiday?(:federalreserve, :observed)
  end

  def federal_reserve_holidays
    holidays(:federalreserve, :observed)
  end
end
range = (Date.parse("2020-01-01")..Date.parse("2040-01-01"))
report = MemoryProfiler.report do
  range.map{|d| d.holiday?(:federalreserve, :observed)}
end
report.pretty_print(to_file: '6.txt')
