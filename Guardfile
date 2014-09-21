# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', cmd: 'rspec --color --format Fuubar' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { "spec" }
  watch('spec/spec_helper.rb')  { "spec" }
end

guard 'cucumber', :notification => true, :cli => '--profile focus' do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})          { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
  watch(%r{^lib/.+\.rb$})                   { 'features' }
  watch(%r{^features/yaml/.+$})             { 'features' }
end
