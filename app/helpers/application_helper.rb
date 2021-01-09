module ApplicationHelper

    include ERB::Util
        
    def auth_token
        html = "<input type='hidden' name='authenticity_token' value="
        html += "#{h(form_authenticity_token)} />"

        html.html_safe
    end

    def ugly_lyrics(lyrics)
        ugly_escape = h(lyrics) # protect from bad input
        ugly_split = ugly_escape.split("\n") # break up in newlines
        ugly_musical = ugly_split.map {|str| "&#9835 #{str}"} # insert a music note at the front
        ugly_preformatted = "<pre>#{ugly_musical.join('').to_s}</pre>" # preserve formatting
        ugly_safe = ugly_preformatted.html_safe
    end
end
