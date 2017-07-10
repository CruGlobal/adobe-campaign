# frozen_string_literal: true
require './spec/support/shared_contexts/rake.rb'

describe 'adobe:generate_jwt' do
  include_context 'rake'

  # its(:prerequisites) { should include("environment") }

  it 'generates a registrations report' do
    expect(subject).to include 'environment'
    subject.invoke
    # ReportGenerator.should have_received(:generate).with("users", csv)
  end

  it 'creates the users report with the correct data' do
    subject.invoke
    # UsersReport.should have_received(:new).with(user_records)
  end
end
