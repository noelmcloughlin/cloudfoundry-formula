# Overide by OS
package_name = 'cf-cli'

control 'cloudfoundry-cli package' do
  title 'should be installed'

  describe package(package_name) do
    it { should be_installed }
  end
end
