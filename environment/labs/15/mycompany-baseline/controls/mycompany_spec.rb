control 'app-01' do
    impact 1.0
    title 'SSH server running'
    desc 'Ensure that the SSH server is listening'
    describe port(22) do
      it { should be_listening }
    end
  end
  
  control 'app-02' do
    impact 1.0
    title 'Editor installed'
    desc 'Ensure that an editor is installed'
    describe package('nano') do
      it { should be_installed }
    end
  end
