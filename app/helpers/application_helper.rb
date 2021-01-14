module ApplicationHelper

    include ERB::Util
        
    def auth_token
        html = "<input type='hidden' name='authenticity_token' value="
        html += "#{h(form_authenticity_token)} />"

        html.html_safe
    end

    def ugly_lyrics(lyrics)
        ugly_escape = h(lyrics) # protect from bad input with short form of html_escape(lyrics)
        ugly_split = ugly_escape.split(/[\n,.!?]/) # break up in newlines and at ,.!? symbols
        ugly_musical = ugly_split.map {|str| "&#9835 #{str}"} # insert a music note at the front
        ugly_preformatted = "<pre>#{ugly_musical.join("\n").to_s}</pre>" # preserve formatting
        ugly_safe = ugly_preformatted.html_safe # we mark it html safe so the erb tag will not "escape" it and thus make it unreadable.
    end
end
