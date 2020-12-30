# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(
    my_id: 'mendako',
    password: "000000",
    name: 'メンダコ',
    email: "mendako@gmail.com",
    profile_image_id: 'a',
    is_deleted: false
  )

# Mission.create!(
#   user_id: 1,
#   title: 'PF制作',
#   record_title: '終了タスク名',
#   deadline_on: 12/31
# )
