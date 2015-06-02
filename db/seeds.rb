user1 = User.create(name:"Candice",email:"c@c.cc",password:"password", phone_number:"999949999")
user2 = User.create(name:"Shannon",email:"s@s.ss",password:"password", phone_number:"999993999")
user3 = User.create(name:"Natty",email:"n@n.nn",password:"password", phone_number:"999999929")
user4 = User.create(name:"Logan",email:"l@l.ll",password:"password", phone_number:"999991999")


user1.decisions.create!(context:"have dinner tonight!")

d = Decision.first

user2.decisions << d
user3.decisions << d
user4.decisions << d

part1 = Participation.all[0]
part2 = Participation.all[1]

part1.proposals.create!(proposed_idea:"DOMINOES", status:"open")

prop1  = Proposal.first
query1 = prop1.queries.create!(participation:part1,status:"yes")

query2 = prop1.queries.create!(participation:part2,status:"yes")
