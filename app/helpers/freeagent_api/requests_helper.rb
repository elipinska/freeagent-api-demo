module FreeagentApi::RequestsHelper
  def display_nested_results(table_contents, results)
    results.each do |field, value|
      if value.respond_to?(:keys)
        display_nested_results(table_contents, value)
      elsif value.respond_to?(:first) && value.first.respond_to?(:keys)
        value.each_with_index do |element, index|
          table_contents << "<tr><td></td><td></td></tr>"
          display_nested_results(table_contents, element)
        end
      else
        table_contents << "<tr><td>#{field.capitalize}</td><td>#{value}</td></tr>"
      end
    end
    table_contents.html_safe
  end

  def results_display_name(api_response)
    api_response.keys.first
  end
end
