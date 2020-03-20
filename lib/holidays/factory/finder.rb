require 'holidays/finder/context/between'
require 'holidays/finder/context/dates_driver_builder'
require 'holidays/finder/context/next_holiday'
require 'holidays/finder/context/parse_options'
require 'holidays/finder/context/search'
require 'holidays/finder/context/year_holiday'
require 'holidays/finder/rules/in_region'
require 'holidays/finder/rules/year_range'

module Holidays
  module Factory
    module Finder
      class << self
        @@_rules = {
          :in_region => Holidays::Finder::Rules::InRegion,
          :year_range => Holidays::Finder::Rules::YearRange,
        }

        def search
          @_search ||= Holidays::Finder::Context::Search.new(
            Factory::Definition.holidays_by_month_repository,
            Factory::Definition.function_processor,
            Factory::DateCalculator.day_of_month_calculator,
            rules,
          )
        end

        def between
          Holidays::Finder::Context::Between.new(
            search,
            dates_driver_builder,
            parse_options,
          )
        end

        def next_holiday
          Holidays::Finder::Context::NextHoliday.new(
            search,
            dates_driver_builder,
            parse_options,
          )
        end

        def year_holiday
          Holidays::Finder::Context::YearHoliday.new(
            search,
            dates_driver_builder,
            parse_options,
          )
        end

        @@_regions_repositories = []
        @@_region_validators = []
        @@_loaders = []
        def parse_options
          #@@_regions_repositories << Factory::Definition.regions_repository
          #@@_region_validators << Factory::Definition.region_validator
          #@@_loaders << Factory::Definition.loader
          #puts "Regions Repositories: #{@@_regions_repositories.uniq.count}"
          #puts "Region Validators: #{@@_region_validators.uniq.count}"
          #puts "Loaders: #{@@_loaders.uniq.count}"
          # Regions Repositories: 3
          # Region Validators: 2907
          # Loaders: 2907
          #binding.pry
          #@@_parse_options ||=
          Holidays::Finder::Context::ParseOptions.new(
            Factory::Definition.regions_repository,
            # This is a function of repository
            Factory::Definition.region_validator,
            Factory::Definition.loader,
          )
        end

        private

        def dates_driver_builder
          @@_dates_driver_builder ||= Holidays::Finder::Context::DatesDriverBuilder.new
        end

        def rules
          @@_rules
        end
      end
    end
  end
end
