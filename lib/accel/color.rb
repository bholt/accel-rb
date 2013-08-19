
class String
    def console_red;          color(:red);         end
    def console_dark_red;     color(:dark_red);    end
    def console_green;        color(:green);       end
    def console_dark_green;   color(:dark_green);  end
    def console_yellow;       color(:yellow);      end
    def console_dark_yellow;  color(:dark_yellow); end
    def console_blue;         color(:blue);        end
    def console_dark_blue;    color(:dark_blue);   end
    def console_purple;       color(:purple);      end

    def console_def;          color(:def);         end
    def console_bold;         color(:bold);        end
    def console_blink;        color(:blink);       end
    
    @@console_end_code = "\001\e[0m\002"
    @@console_color_codes = {
      red: "\001\e[1m\e[31m\002",
      dark_red: "\001\e[31m\002",
      green: "\001\e[1m\e[32m\002",
      dark_green: "\001\e[32m\002",
      yellow: "\001\e[1m\e[33m\002",
      dark_yellow: "\001\e[33m\002",
      blue: "\001\e[1m\e[34m\002",
      dark_blue: "\001\e[34m\002",
      purple: "\001\e[1m\e[35m\002",
      def: "\001\e[1m\002",
      bold: "\001\e[1m\002",
      blink: "\001\e[5m\002",
    }
    
    def color(name)
      "#{@@console_color_codes[name]}#{self}#{@@console_end_code}"
    end
end
