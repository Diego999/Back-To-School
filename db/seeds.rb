# ruby encoding: utf-8

est_list = ['HE-Arc', 'EPFL', 'ETHZ']

est_list.each do |est|
  Establishment.create(:name => est)
end

establishments = Establishment.all

10.times { Discussion.new().save(validate: false) }
discussions = Discussion.all

establishments[0].discussions << discussions[0]
establishments[1].discussions << discussions[1]
establishments[2].discussions << discussions[2]

user_list = [
    ['admin', 'admin', 'admin@b2s.com', 'admin1234', true, false, false, false, nil, []],
    ['HE-Arc1', 'HE-Arc1', 'he-arc1@b2s.com', 'HE-Arc11234', false, true, false, false, establishments[0], []],
    ['HE-Arc2', 'HE-Arc2', 'he-arc2@b2s.com', 'HE-Arc21234', false, true, false, false, establishments[0], []],
    ['EPFL', 'EPFL', 'epfl@b2s.com', 'EPFL1234', false, true, false, false, establishments[1], []],
    ['ETHZ', 'ETHZ', 'ethz@b2s.com', 'ETHZ1234', false, true, false, false, establishments[2], []],
    ['Diego', 'Antognini', 'diego.antognini@he-arc.ch', 'Diego1234', false, false, false, true, nil, [discussions[5], discussions[6], discussions[8], discussions[9]]],
    ['David', 'Kuhner', 'david.kuhner@he-arc.ch', 'David1234', false, false, false, true, nil, [discussions[5], discussions[7], discussions[8], discussions[9]]],
    ['Marco', 'Aeberli', 'marco.aeberli@he-arc.ch', 'Marco1234', false, false, false, true, nil, [discussions[6], discussions[7], discussions[8], discussions[9]]],
    ['Axel', 'Bulher', 'axel.buhler@epfl.ch', 'Axel1234', false, false, false, true, nil, []],
    ['Olivier', 'Simon', 'olivier.simon@epfl.ch', 'Olivier1234', false, false, false, true, nil, []],
    ['Samuel', 'von Ehrenberg', 'samuel.vonehrenberg@ethz.ch', 'Samuel1234', false, false, false, true, nil, []],
    ['Adrian', 'Moll', 'adrian.moll@he-arc.ch', 'Adrian1234', false, false, false, true, nil, []],
    ['Michael', 'Muller', 'michael.muller@he-arc.ch', 'Michael1234', false, false, false, true, nil, [discussions[9]]],
    ['Cyril', 'Machin', 'cyril.machi@he-arc.ch', 'Cyril1234', false, false, false, true, nil, [discussions[9]]]
]
user_list.each do |user|
  User.new(:firstname => user[0], :lastname => user[1], :email => user[2], :password => user[3], :admin => user[4], :est_admin => user[5], :professor => user[6], :student => user[7], :establishment => user[8], :discussions => user[9]).save(validate: false)
end
users = User.all


promo_list = [
    ['DLM2014', establishments[0], [discussions[3]], [users[5], users[6], users[7], users[11], users[12]]],
    ['IEE2014', establishments[0], [discussions[4]], [users[12], users[13]]],
    ['PHY2014', establishments[1], [], [users[8], users[9]]],
    ['STI2016', establishments[2], [], [users[10]]]
]
promo_list.each do |promo|
  Promotion.create(:name => promo[0], :establishment => promo[1], :discussions => promo[2], :students => promo[3])
end
promotions = Promotion.all


event_list = [
    ['2014-03-26', 'Bal HEARC', 'Neuchâtel', discussions[0], users[0]],
    ['2014-03-26', 'Bal EPFL', 'Lausanne', discussions[1], users[3]],
    ['2014-03-26', 'Bal ETH', 'Zurich', discussions[2], users[5]],
    ['2014-03-15', 'Petit verre', 'St-Imier', discussions[3], users[11]]
]
event_list.each do |event|
  Event.create(:date => event[0], :name => event[1], :location => event[2], :discussion => event[3], :user => event[4])
end

msg_list = [
    ['Venez nombreux HEARC', '2014-02-28 00:00:00', discussions[0], users[1]],
    ['Venez nombreux EPFL', '2014-03-01 00:00:00', discussions[1], users[3]],
    ['Venez nombreux ETHZ', '2014-03-02 00:00:00', discussions[2], users[4]],
    ['Comment allez-vous ?', '2014-03-01 00:00:00', discussions[3], users[5]],
    ['Bien merci', '2014-03-02 00:00:00', discussions[3], users[6]],
    ['Nickel', '2014-03-03 00:00:00', discussions[3], users[7]],
    ['Super', '2014-03-04 00:00:00', discussions[3], users[11]],
    ['IEE dans la place !', '2014-03-03 00:00:00', discussions[4], users[12]],
    ['IEE > all', '2014-03-05 00:00:00', discussions[4], users[13]],
    ['M1', '2014-03-01 00:00:00', discussions[5], users[5]],
    ['M2', '2014-03-02 00:00:00', discussions[5], users[6]],
    ['M1', '2014-03-01 00:00:00', discussions[6], users[5]],
    ['M2', '2014-03-02 00:00:00', discussions[6], users[7]],
    ['M1', '2014-03-01 00:00:00', discussions[7], users[6]],
    ['M2', '2014-03-02 00:00:00', discussions[7], users[7]],
    ['M1', '2014-03-01 00:00:00', discussions[8], users[5]],
    ['M2', '2014-03-02 00:00:00', discussions[8], users[6]],
    ['M3', '2014-03-03 00:00:00', discussions[8], users[7]],
    ['M1', '2014-03-01 00:00:00', discussions[9], users[5]],
    ['M2', '2014-03-02 00:00:00', discussions[9], users[7]],
    ['M3', '2014-03-03 00:00:00', discussions[9], users[6]],
    ['M4', '2014-03-04 00:00:00', discussions[9], users[12]],
    ['M5', '2014-03-05 00:00:00', discussions[9], users[13]]
]
msg_list.each do |msg|
  Message.create(:message => msg[0], :created_at => msg[1], :discussion => msg[2], :user => msg[3])
end

follower_list = [
    [false, promotions[0], users[13]],
    [false, promotions[1], users[7]],
    [true, promotions[1], users[5]]
]

follower_list.each do |flw|
  Follower.create(:accepted => flw[0], :promotion => flw[1], :user => flw[2])
end
