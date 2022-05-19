# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Exercise.destroy_all
Diet.destroy_all
UserExercise.destroy_all

u1= User.create(name: 'Mayank Agarwal', email: 'mayank.agarwal0903@gmail.com', password: 'test12',password_confirmation: 'test12', role: :admin)
u2= User.create(name: 'Rahul Agarwal', email: 'rahulagarwal@gmail.com', password: 'test12', password_confirmation: 'test12')

e1= Exercise.create(name: 'Deadlift', description: 'Exercise for back', category: 'Back', link: 'https://www.youtube.com/watch?v=ytGaGIn3SjE
')
e2= Exercise.create(name: 'Bicep Curl', description: 'Exercise for arm', category: 'Arm', link: 'https://www.youtube.com/watch?v=ykJmrZ5v0Oo
')
e3= Exercise.create(name: 'Benchpress', description: 'Exercise for chest', category: 'Chest', link: 'https://www.youtube.com/watch?v=vthMCtgVtFw
')
e4= Exercise.create(name: 'Chest Dip', description: 'Exercise for chest', category: 'Chest', link: 'https://www.youtube.com/watch?v=Gj10s7hsq7s
')
e5= Exercise.create(name: 'Leg Raises', description: 'Exercise for abs', category: 'Abs', link: 'https://www.youtube.com/watch?v=JB2oyawG9KI
')
e6= Exercise.create(name: 'Crunches', description: 'Exercise for abs', category: 'Abs', link: 'https://www.youtube.com/watch?v=5ER5Of4MOPI
')
e7= Exercise.create(name: 'Shoulder Press', description: 'Exercise for shoulder', category: 'Shoulder', link: 'https://www.youtube.com/watch?v=qEwKCR5JCog
')
e8= Exercise.create(name: 'Front Raise', description: 'Exercise for shoulder', category: 'Shoulder', link: 'https://www.youtube.com/watch?v=lXere8G5j20
')
e9= Exercise.create(name: 'Skipping', description: 'Exercise for legs', category: 'Leg', link: 'https://www.youtube.com/watch?v=1BZM2Vre5oc
')
e10= Exercise.create(name: 'Squats', description: 'Exercise for legs', category: 'Leg', link: 'https://www.youtube.com/watch?v=YaXPRqUwItQ
')
e11= Exercise.create(name: 'Lunges', description: 'Exercise for legs', category: 'Leg', link: 'https://www.youtube.com/watch?v=wrwwXE_x-pQ
')
e12= Exercise.create(name: 'Pushups', description: 'Exercise for arms', category: 'Arm', link: 'https://www.youtube.com/watch?v=IODxDxX7oi4
')
e13= Exercise.create(name: 'Tricep Dip', description: 'Exercise for arms', category: 'Arm', link: 'https://www.youtube.com/watch?v=6kALZikXxLc
')
e14= Exercise.create(name: 'Plank to Push up', description: 'Exercise for amrs', category: 'Arm', link: 'https://www.youtube.com/watch?v=nToxCj-QA7E
')
e15= Exercise.create(name: 'Step Ups', description: 'Exercise for legs', category: 'Leg', link: 'https://www.youtube.com/watch?v=WCFCdxzFBa4
')
e16= Exercise.create(name: 'Cable Crossover', description: 'Exercise for chest', category: 'Chest', link: 'https://www.youtube.com/watch?v=taI4XduLpTk
')
e17= Exercise.create(name: 'Decline Bench press', description:'Exercise for chest', category: 'Chest', link: 'https://www.youtube.com/watch?v=OR6WM5Z2Hqs
')
e18= Exercise.create(name: 'Lateral Raise', description: 'Exercise for shoulder', category: 'Shoulder', link: 'https://www.youtube.com/watch?v=WJm9zA2NY8E
')
e19= Exercise.create(name: 'Plank', description: 'Exercise for abs', category: 'Abs', link: 'https://www.youtube.com/watch?v=yeKv5oX_6GY
')
e20= Exercise.create(name: 'Superman Holds', description: 'Exercise for back', category: 'Back', link: 'https://www.youtube.com/watch?v=ZNVWTVdJW5s
')
e21= Exercise.create(name: 'Bent-Over Row', description: 'Exercise for back', category: 'Back', link: 'https://www.youtube.com/watch?v=kBWAon7ItDw
')

d1= Diet.create(name: '1 banana', exercise_id: e1.id)
d2= Diet.create(name: '2 apple', exercise_id: e2.id)
d3= Diet.create(name: '1 protein shake', exercise_id: e3.id)
d4= Diet.create(name: '1 glass milk', exercise_id: e4.id)
d5= Diet.create(name: '2 glass orange juice', exercise_id: e5.id)
d6= Diet.create(name: '1 mango', exercise_id: e6.id)
d7= Diet.create(name: '200gm paneer', exercise_id: e7.id)
d8= Diet.create(name: '100gm soyachunks', exercise_id: e8.id)
d9= Diet.create(name: '100gm chicken', exercise_id: e9.id)
d10= Diet.create(name: '1 pizza', exercise_id: e10.id)
d11= Diet.create(name: '1 chole bhatura', exercise_id: e11.id)
d12= Diet.create(name: '1 banana shake', exercise_id: e12.id)
d13= Diet.create(name: '1 dosa', exercise_id: e13.id)
d14= Diet.create(name: '1 full thaali', exercise_id: e14.id)
d15= Diet.create(name: '3 fruits', exercise_id: e15.id)
d16= Diet.create(name: '100gm dry fruits', exercise_id: e16.id)
d17= Diet.create(name: 'Oats', exercise_id: e17.id)
d18= Diet.create(name: 'Masala Oats', exercise_id: e18.id)
d19= Diet.create(name: 'Paneer sandwich', exercise_id: e19.id)
d20= Diet.create(name: 'Sandwich', exercise_id: e20.id)
d21= Diet.create(name: 'Masala dosa', exercise_id: e21.id)

ue1= UserExercise.create(user_id: u2.id, exercise_id: e1.id)
ue2= UserExercise.create(user_id: u2.id, exercise_id: e2.id)
ue3= UserExercise.create(user_id: u2.id, exercise_id: e3.id)
ue4= UserExercise.create(user_id: u2.id, exercise_id: e4.id)
ue5= UserExercise.create(user_id: u2.id, exercise_id: e5.id)
ue6= UserExercise.create(user_id: u2.id, exercise_id: e6.id)
ue7= UserExercise.create(user_id: u2.id, exercise_id: e7.id)
ue8= UserExercise.create(user_id: u2.id, exercise_id: e8.id)
ue9= UserExercise.create(user_id: u2.id, exercise_id: e9.id)
ue10= UserExercise.create(user_id: u2.id, exercise_id: e10.id)
ue11= UserExercise.create(user_id: u2.id, exercise_id: e11.id)
ue12= UserExercise.create(user_id: u2.id, exercise_id: e12.id)
ue13= UserExercise.create(user_id: u2.id, exercise_id: e13.id)
ue14= UserExercise.create(user_id: u2.id, exercise_id: e14.id)
ue15= UserExercise.create(user_id: u2.id, exercise_id: e15.id)
ue16= UserExercise.create(user_id: u2.id, exercise_id: e16.id)
ue17= UserExercise.create(user_id: u2.id, exercise_id: e17.id)
ue18= UserExercise.create(user_id: u2.id, exercise_id: e18.id)
ue19= UserExercise.create(user_id: u2.id, exercise_id: e19.id)
ue20= UserExercise.create(user_id: u2.id, exercise_id: e20.id)
ue21= UserExercise.create(user_id: u2.id, exercise_id: e21.id)
