module FreeagentApi::RequestsHelper
  def display_nested_results(table_contents, api_response)
      if api_response.respond_to?(:keys)
        api_response.each do |field, value|
          if value.respond_to?(:keys)
            display_nested_results(table_contents, value)
          elsif value.is_a?(Array)
            value.each_with_index do |v, i|
              table_contents << "<tr><td><b>#{field.singularize.capitalize} #{i + 1}</b></td><td></td></tr>"
              display_nested_results(table_contents, v)
            end
          else
            table_contents << "<tr><td>#{field.capitalize}</td><td>#{value}</td></tr>"
          end
        end
      end
    table_contents.html_safe
  end

  def results_display_name(api_response)
    api_response.keys.first
  end
end
