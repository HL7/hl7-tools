module ApplicationHelper
  def is_admin?
    ENV['HL7_TOOL_EDITING'] == 'TRUE'
  end

  def truncate_words(text, length = 30, end_string = '')
    words = text.split()
    words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')
  end
end
