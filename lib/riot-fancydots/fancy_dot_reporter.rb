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
      @details << "#{yellow bold('FAILURE')} #{green dark(line_info(line, file))} #{test_detail(description, message)}".strip
    end

    def error(description, e)
      print red("E")
      location = filter_backtrace(e.backtrace).last
      @details << "#{red bold('ERROR')}   #{green dark(line_info(*location.split(':').reverse))} #{test_detail(description, white(dark(format_error e)))}"
    end

    def results(time_taken)
      puts "\n\n#{@details.join("\n\n")}" unless @details.empty?
      super
    end
  private
    def test_detail(description, message)
      "#{current_context.detailed_description} #{description}\n#{white bold("=>")} #{message}"
    end
#need to make this protected
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
