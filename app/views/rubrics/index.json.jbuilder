json.array!(@rubrics) do |rubric|
  json.extract! rubric, :name
  json.url rubric_url(rubric, format: :json)
end
