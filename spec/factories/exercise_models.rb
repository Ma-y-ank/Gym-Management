FactoryBot.define do
  factory :exercise do
    name {Faker::Name.name}
    category  {'Back'}
    description {'lorem ipsum'}
    link {'https://www.youtube.com/watch?v=AAqPc0j_2bg'}
  end
end