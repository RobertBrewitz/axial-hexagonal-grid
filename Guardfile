# Requires guard-shell

def run_spec(spec)
  system("./node_modules/jasmine-node/bin/jasmine-node --forceexit --verbose --noStack --captureExceptions --coffee #{spec}")
end

def process_spec(spec)
  if File.exists?(spec)
    if run_spec(spec)
      n "#{spec}: Specs passed", 'jasmine', :success
    else
      n "#{spec}: Specs failed", 'jasmine', :failed
    end
    "#{spec}: Specs run at #{Time.now.asctime}."
  end
end

guard :shell do

  watch %r|spec/.*_spec\.\w+$| do |m| process_spec m[0] end

  watch %r"(.+)\.js$" do |m|
    dir = ''
    basename = m[1]

    if m[1] =~ %r|(.*/)(.+)\.\w+$|
      dir = $1
      basename = $2
    end

    process_spec "spec/#{dir}#{basename}_spec.js"
    process_spec "spec/#{dir}#{basename}_spec.coffee"
  end
end
