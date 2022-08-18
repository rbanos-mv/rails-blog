# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user1 = User.create(name: 'Tom', photo: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                    bio: 'Teacher from Mexico.')
user2 = User.create(name: 'Lilly', photo: 'https://cdn-icons-png.flaticon.com/512/219/219969.png',
                    bio: 'Teacher from Poland.')

Post.create(author: user1, title: 'Hello 1', text: 'This is my first post')
Post.create(author: user1, title: 'Hello 2', text: 'This is my second post')
post = Post.create(author: user1, title: 'Hello 3', text: "Contrary to popular belief, Lorem Ipsum \
is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making \
it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, \
looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going \
through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum \
comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good \
and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular \
during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a \
line in section 1.10.32.

The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. \
Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in \
their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.")
Post.create(author: user1, title: 'Hello 4', text: 'This is my fourth post')
Comment.create(post:, author: user2, text: 'Hi Tom 1!')
Comment.create(post:, author: user2, text: 'Hi Tom 2!')
Comment.create(post:, author: user2, text: 'Hi Tom 3!')
Comment.create(post:, author: user2, text: 'Hi Tom 4!')
Comment.create(post:, author: user2, text: 'Hi Tom 5!')
Comment.create(post:, author: user2, text: 'Hi Tom 6!')
