module ApplicationHelper
  def is_admin?
    ENV['HL7_TOOL_EDITING'] == 'TRUE'
  end

  def truncate_words(text, length=50, trailing=nil)
    if text.length < length
      text
    else
      full_words = ''
      text.split(/\s+/).each do |word|
        if (full_words.length + word.length/2) < length
          full_words << ' ' << word
        end
      end
      if trailing
        full_words << trailing
      end
      full_words
    end
  end

  def reformat_para(s, width=80)
    lines = []
    line = ''
    s.split(/\s+/).each do |word|
      if line.size + word.size >= width
        lines << line
        line = word
      elsif line.empty?
        line = word
      else
        line << ' ' << word
      end
    end
    lines << line if line
    lines
  end
end
