class User
  include Mongoid::Document
  include Mongoid::Timestamps
  attr_accessor :password, :user_name, :faculdade, :cidade, :skills, :interesses, :id_empresa

  #convenience method for access to client in console
  def self.mongo_client
    Mongoid::Clients.default
  end
  #convenience method for access the colelction
  def self.collection
    self.mongo_client[:jhunterusers]
  end

  def save(e)
    SymmetricEncryption.load!
    pass = SymmetricEncryption.encrypt e.password
    self.class.collection.insert_one(user_name: e.user_name,
                                      password: pass,
                                      faculdade: e.faculdade,
                                      cidade: e.cidade,
                                      skills: e.skills)
  end

  def self.inserir_interesse(p, session)
    interesses = Array.new
    usr = collection.find(_id: BSON::ObjectId(session['$oid'])).first
    usr = User.new(usr)
    v = usr.interesses
    for i in v
      interesses << i
    end
      interesses << {
                :id_empresa => p['id_empresa'],
                :nome_vaga => p['nome_vaga'],
                :skills_necessarios => p['skills_necessarios'],
                :descricao => p['descricao']}

    collection.find(_id: BSON::ObjectId(session['$oid'])).update_one("$set" => { :interesses => interesses})
  end



  def self.return_user_data(session)
    doc = collection.find(_id: BSON::ObjectId(session['$oid'])).first
    return doc.nil? ? nil : User.new(doc)
  end

  def self.return_skills_user(session)
    usr = collection.find(_id: BSON::ObjectId(session['$oid'])).first
    usr = User.new(usr)
    skills_array = Array.new
    skills_string = usr.skills
    skill_array = skills_string.split(/,/)
    return skill_array
  end

  def self.return_skills_interesses(session)
    usr = collection.find(_id: BSON::ObjectId(session['$oid'])).first
    usr = User.new(usr)
    vaga = Array.new
    vagas = Array.new
    skills_interesses = usr.interesses

    skills_interesses.each do |s|
      skill_nome_vaga = s['nome_vaga']
      skill_string = s['skills_necessarios']
      vaga << skill_nome_vaga
      vaga << skill_string
      vagas << vaga
    end


    return vagas
  end

  def self.find(name, pass)
    SymmetricEncryption.load!
    pass = SymmetricEncryption.encrypt pass
    doc = collection.find(user_name: name, password: pass).first
    return doc.nil? ? nil : User.new(doc)
  end

  def self.find_session(session)
    doc = collection.find(_id: BSON::ObjectId(session['$oid'])).first
    return doc.nil? ? nil : User.new(doc)
  end

  def self.split(texto, x)
    return texto.split(/x/)
  end
end
