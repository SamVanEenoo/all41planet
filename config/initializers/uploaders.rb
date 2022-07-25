Dir.glob(Rails.root.join('app', 'uploaders', '*.rb')).each do |f|
  require f
end
