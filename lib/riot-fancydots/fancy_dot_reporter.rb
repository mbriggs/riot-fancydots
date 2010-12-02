module Riot
  class FancyDotReporter < IOReporter
    def initialize(writer=STDOUT)
      super
      puts "\n"
      @details = []
    end

    def pass(description, message)
      print green(".")
    end

    def fail(description, message, line, file)
      print yellow("F")
      @details << "#{yellow bold('FAILURE')} #{test_description(description)} #{green line_info(line, file)} #{test_detail(message)}".strip
    end

    def error(description, e)
      print red("E")
      location = filter_backtrace(e.backtrace).last
      @details << "#{red bold('ERROR')}   #{test_description(description)} #{green line_info(*location.split(':').reverse)} #{test_detail(test_error e)}"
    end

    def results(time_taken)
      puts "\n\n#{@details.join("\n\n")}" unless @details.empty?
      super
    end

private
    def test_detail(message)
      "\n#{white bold("=>")} #{message}"
    end

    def test_error(e)
      lines = format_error(e).split("\n")
      error = lines.shift

      "#{error.strip}\n #{dark lines.join("\n")}"
    end

    def test_description(description)
      "#{current_context.detailed_description} #{description}"
    end

#need to make this protected in IOReporter
    def filter_backtrace(backtrace)
      cleansed = []
      bad = true

      # goal is to filter all the riot stuff/rake before the first non riot thing
      backtrace.reverse_each do |bt|
        # make sure we are still in the bad part
        bad = (bt =~ /\/lib\/riot/ || bt =~ /rake_test_loader/) if bad

        cleansed.unshift bt unless bad
      end

      cleansed.empty?? backtrace : cleansed
    end
  end
end
