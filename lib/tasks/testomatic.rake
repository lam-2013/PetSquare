namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Flavia",
                         email: "flaflifle@hotmail.it",
                         password: "123456",
                         password_confirmation: "123456")
    admin.toggle!(:admin)
    10.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@petsquare.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end


    users = User.all(limit: 6)
    10.times do |n|
      if n.odd?
        breed= "barboncino"
        description="funny"
      else
        breed= "volpino"
        description="happy"
      end
      users.each { |user| user.pets.create!(namePet: "fuffyOf#{user.name}#{n}",
                                            breed: breed,
                                            description: description) }
    end
  end

    #da provare
    desc "add follower to pet"
    task :relationships => :environment do
      pets = Pet.all(limit: 10)
      users = User.all(limit: 6)
      users.each{ |follower|
        pets.each{ |followed| follower.follow!(followed)}
      }
    end


    desc "add mock places in DB"
    task :places => :environment do
      lat,lon = 45.071069,7.685231
      10.times do |i|
        if i.odd?
            cat="parco"
        else
            cat="alimentari"
        end
        lat -= 0.01
        Place.create!(name:"localita #{i}", street:Faker::Address.street_name, city:Faker::Address.city,
                     country:Faker::Address.country, latitude:lat, longitude:lon, category:cat, gmaps:true,
                     description:"un ottimo luogo per condividere il tempo con il proprio animale")
      end
    end

  desc "add checkin in db"
   task :checkins => :environment do
     places=Place.all(limit: 4)
     users=User.all
     places.each{ |place|
       users.each{ |user|
         pet = user.pets.first
         if pet
           Checkin.create!(place_id: place.id, user_id: user.id, pet_id: pet.id,
                         wayd:Faker::Lorem.sentence(4))
         end
       }
     }
   end

  desc "add mock in review db"
    task :reviews => :environment do
      users=User.all(limit: 4)
      places=Place.all(limit: 10)
      places.each{ |place|
      users.each{ |user| Review.create!(body:Faker::Lorem.sentence(5),place:place,
                                      user:user)
        }
      }
    end


end