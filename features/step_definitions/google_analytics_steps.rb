Before do
  @ga = GoogleAnalyticsSupport.new
end

Given /^I am on the "([^"]*)" page$/ do |path|
  visit "#{host()}/#{path}?google-analytics-debug"
end

When /^I wait for (\d+) seconds$/ do |seconds|
  sleep(seconds.to_i)
end

Then /^the google analytics account should be "([^"]*)"$/ do |account_id|
  @ga.account.should_not be_nil, "account should be '#{account_id}', but was not set"
  @ga.account.should eql(account_id), "account should be '#{account_id}', but was '#{@ga.account}'"
end

Then /^the google analytics domain should be "([^"]*)"$/ do |domain|
  @ga.domain.should_not be_nil, "domain should be '#{domain}', but was not set"
  @ga.domain.should eql(domain), "domain should be '#{domain}', but was '#{@ga.domain}'"
end

Then /^the "([^"]*)" should be "([^"]*)" at "((?:visitor|session|page)-level)"$/ do |category, value, scope|
  custom_var = @ga.custom_variables[category]
  custom_var.should_not be_nil, "Custom Variable '#{custom_var}' should be '#{value}', but was not set"
  custom_var.value.should eql(value), "Custom Variable '#{custom_var}' should be '#{value}', but was '#{custom_var.value}'"
  custom_var.scope_name.should eql(scope), "Custom Variable '#{custom_var}' should be '#{scope}', but was '#{custom_var.scope_name}/#{custom_var.scope}'"
end

Then /^the event "([^"]*)" for "([^"]*)" will be triggered$/ do |label, category|
  @ga.events[category].should_not be_nil, "event of '#{category} => #{label}' should be fired, no event was fired"
  @ga.events[category].labels.should include(label),"event of '#{category} => #{label}' should be fired, only #{@ga.events[category].labels} were fired"
end

