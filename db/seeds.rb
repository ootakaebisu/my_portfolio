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
    is_deleted: false
  )

  User.create!(
    my_id: 'mendako2',
    password: "000000",
    name: 'メンダコ2',
    email: "mendako2@gmail.com",
    is_deleted: false
  )

Mission.create!(
  user_id: 1,
  title: 'PF制作',
  record_title: '終了タスク名',
  deadline_on: 12/31
)

Calendar.create!(
  user_id: 1,
  title: 'PF制作',
  description: 'tesuto',
  start_date: Time.now,
  end_date: Time.now
)

Gantt.create!(
  user_id: 1,
  name: 1,
  desc: 'ガント',
  from: Time.now,
  to: Time.now,
  label: 'ラベルデータ',
  customClass: 'クラス'
)







