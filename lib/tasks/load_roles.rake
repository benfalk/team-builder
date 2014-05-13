begin
  namespace :db do
    namespace :lol_roles do

      desc 'Loads the LOL Meta roles into the sytem'
      task :sync => :environment do
        [
          {map: 'CLASSIC', name:'Top'},
          {map: 'CLASSIC', name:'Mid'},
          {map: 'CLASSIC', name:'Jungle'},
          {map: 'CLASSIC', name:'ADC'},
          {map: 'CLASSIC', name:'Support'}
        ].each do |role|
          Role.where(role).first_or_create
        end
      end

    end
  end
end
