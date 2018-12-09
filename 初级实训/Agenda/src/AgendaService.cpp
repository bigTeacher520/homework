#include "AgendaService.hpp"

  //std::shared_ptr<Storage> m_storage;
  AgendaService::AgendaService(){
    AgendaService::startAgenda();
  }

  AgendaService::~AgendaService(){
    AgendaService::quitAgenda();
  }

  bool AgendaService::userLogIn(const std::string &userName, const std::string &password){
    User mid_user(userName,password,"","");
    std::list<User> mid=m_storage->queryUser( [&](const User &user)->bool{
        if(user.getName()==mid_user.getName() and user.getPassword()==mid_user.getPassword()) return true;
        else return false;
    }
    );
    if(mid.size()==0) return false;
    else return true;
  }
  bool AgendaService::userRegister(const std::string &userName, const std::string &password,const std::string &email, const std::string &phone){
  	std::list<User> sss=listAllUsers();
  	for(auto i : sss){
  		if(i.getName()==userName) return false;
	  }
      User mid(userName,password,email,phone);
      m_storage->createUser(mid);
      return true;
    }


  bool AgendaService::deleteUser(const std::string &userName, const std::string &password){
    bool res=AgendaService::userLogIn(userName,password);
    std::list<Meeting> m_me=listAllMeetings(userName);
    for(auto i :m_me){
    	if(i.getSponsor()==userName) deleteMeeting(userName,i.getTitle());
    	else{
    		quitMeeting(userName,i.getTitle());
		}
	}
	User mid(userName,password,"","");
    if(!res) return false;
    int sur=m_storage->deleteUser([&](const User &user)->bool{
        if(user.getName()==mid.getName() and user.getPassword()==mid.getPassword()) return true;
        else return false;
    });
	return sur!=0;
  }


  std::list<User> AgendaService::listAllUsers(void) const{
    return m_storage->queryUser([](const User user)->bool{return true;});
  }

  bool AgendaService::createMeeting(const std::string &userName, const std::string &title,const std::string &startDate, const std::string &endDate,const std::vector<std::string> &participator){
    
    for(int i=0;i<participator.size()-1;i++){
    	std::string name=participator[i]; 
		for(int j=i+1;j<participator.size();j++){
    		if(name==participator[j]) return false;
		}
	}
	if(!Date::isValid(startDate) or !Date::isValid(endDate) ) return false;
    Date Me_start(startDate);
    Date Me_end(endDate);
    std::vector<std::string> me_str;
    me_str.push_back(userName);
    for(int i=0;i<participator.size();i++){
    	me_str.push_back(participator[i]);
	}
    if(Me_start>=Me_end) return false;
    if(participator.size()==0) return false;
    if(m_storage->queryUser([&](const User &user)->bool{
            if(user.getName()==userName) return true;
            else return false;
        }).size()==0) return false;
    for(int i=0;i<participator.size();i++){
        if(participator[i]==userName) return false;
        if(m_storage->queryUser([=](const User &user)->bool{
            if(user.getName()==participator[i]) return true;
            else return false;
        }).size()==0) return false;
    }//judge the user and participator if they are in the Storage
    Meeting mid_meeting(userName,participator,Me_start,Me_end,title);
    std::list<Meeting> mid=m_storage->queryMeeting([&](const Meeting &meeting)->bool{
        if(meeting.getTitle()==mid_meeting.getTitle()) return true;
        else return false;
    });
    if(mid.size()!=0) return false;
    for(int i=0;i<me_str.size();i++){
        std::list<Meeting> kk=m_storage->queryMeeting([=](const Meeting &meeting)->bool{
            if(!(me_str[i] == meeting.getSponsor() or meeting.isParticipator(me_str[i]))) return false;
            if(meeting.getStartDate()>=Me_end or meeting.getEndDate()<=Me_start) return false;
            return true;
        });
        if(kk.size()!=0) return false;
    }
    m_storage->createMeeting(mid_meeting);
    return true;
  }


  bool AgendaService::addMeetingParticipator(const std::string &userName,const std::string &title,const std::string &participator){
    std::list<Meeting> mid_meeting=m_storage->queryMeeting([=](const Meeting &meeting)->bool{
        if(meeting.getSponsor()==userName and meeting.getTitle()==title) return true;
        return false;
    });
    if(mid_meeting.size()==0) return false;
	std::list<User> mid_user=m_storage->queryUser([=](const User &user)->bool{
        if(user.getName()==participator) return true;
        return false;
    });
    if(mid_user.size()==0) return false;
    
    Meeting meet=mid_meeting.back();
    if(meet.isParticipator(participator) or meet.getSponsor()==participator) return false;
    std::list<Meeting> me_meeting=m_storage->queryMeeting([&](const Meeting &meeting)->bool{
        if(meeting.getSponsor()==participator ) return true;
        return false;
    });
    std::list<Meeting> you_meeting=m_storage->queryMeeting([&](const Meeting &meeting)->bool{
        std::vector<std::string> part=meeting.getParticipator();
        for(int i=0;i<part.size();i++){
            if(part[i]==participator) return true;
        }
        return false;
    });
    Date me_start=meet.getStartDate();
    Date me_end=meet.getEndDate();
    std::list<Meeting> sob;
    for(auto mid:me_meeting){
     if(!(mid.getStartDate()>=me_end or mid.getEndDate()<=me_start)) return false;
    }
    for(auto mid:you_meeting){
     if(!(mid.getStartDate()>=me_end or mid.getEndDate()<=me_start)) return false;
    }
    return m_storage -> updateMeeting([userName,title](const Meeting & meeting) -> bool 
      { 
        return ( meeting.getTitle() == title && meeting.getSponsor() == userName ) ;
      } , [participator](Meeting & meeting){
             meeting.addParticipator(participator);
    	} 
    );
  }


  bool AgendaService::removeMeetingParticipator(const std::string &userName,const std::string &title,const std::string &participator){
    std::list<User> mid_user=m_storage->queryUser([=](const User &user)->bool{
        if(user.getName()==participator) return true;
        return false;
    });
    if(mid_user.size()==0) return false;
    std::list<Meeting> mid_meeting=m_storage->queryMeeting([=](const Meeting &meeting)->bool{
        if(meeting.getSponsor()==userName and meeting.getTitle()==title) return true;
        return false;
    });
    if(mid_meeting.size()==0) return false;
    Meeting meet=mid_meeting.front();
    if(!meet.isParticipator(participator)) return false;
	if(meet.getSponsor()==participator) return false;
	if(meet.getParticipator().size()==1 and meet.isParticipator(participator)) {
		deleteMeeting(userName,title) ;
	}
    m_storage->updateMeeting([userName,title](const Meeting &meeting)->bool{
        return meeting.getSponsor()==userName and meeting.getTitle()==title;
    },[participator](Meeting &meeting){
        meeting.removeParticipator(participator);}
    );
    return true;
  }


  bool AgendaService::quitMeeting(const std::string &userName, const std::string &title){
        std::list<Meeting> m_meeting=m_storage->queryMeeting([&](const Meeting &meeting )->bool{return true;});
        Meeting my;
        std::string spon;
        int size=0;
        for(auto mid:m_meeting){
            if(mid.getTitle()==title){
            	if(mid.getSponsor()==userName ) return false;
                spon=mid.getSponsor();
                size++;
            }
        }
        if(size==0) return false;
		return removeMeetingParticipator(spon,title,userName); 
  }


  std::list<Meeting> AgendaService::meetingQuery(const std::string &userName,const std::string &title) const{
    return m_storage->queryMeeting([&](const Meeting &meeting)->bool{
        if(meeting.getSponsor()==userName or meeting.isParticipator(userName)){
            if(meeting.getTitle()==title)return true;
            return false;
        }
        return false;
    });
  }

  std::list<Meeting> AgendaService::meetingQuery(const std::string &userName,const std::string &startDate,const std::string &endDate) const{
    std::list<Meeting> mid;
    if(!Date::isValid(startDate) or !Date::isValid(endDate)) return mid;
    Date m_start(startDate);
    Date m_end(endDate);
    if(m_start>m_end) return mid;
    return m_storage->queryMeeting([&](const Meeting meeting)->bool{
        if(meeting.getSponsor()==userName or meeting.isParticipator(userName)){
            if(!(meeting.getStartDate()>m_end or meeting.getEndDate()<m_start)) return true;
            return false;
        }
        return false;
    });
    
  }


  std::list<Meeting> AgendaService::listAllMeetings(const std::string &userName) const{
    return m_storage->queryMeeting([&](const Meeting &meeting)->bool{
        if(meeting.getSponsor()==userName or meeting.isParticipator(userName)) return true;
        return false;
    });
  }

  std::list<Meeting> AgendaService::listAllSponsorMeetings(const std::string &userName) const{
    return m_storage->queryMeeting([&](const Meeting &meeting)->bool{
        if(meeting.getSponsor()==userName) return true;
        return false;
    });
  }


  std::list<Meeting> AgendaService::listAllParticipateMeetings(const std::string &userName) const{
    return m_storage->queryMeeting([&](const Meeting &meeting)->bool{
        if(meeting.isParticipator(userName)) return true;
        return false;
    });
  }


  bool AgendaService::deleteMeeting(const std::string &userName, const std::string &title){
    int mid=m_storage->deleteMeeting([&](const Meeting meeting)->bool{
        if(meeting.getSponsor()==userName and meeting.getTitle()==title) return true;
        return false;
    });
    if(mid!=0) return true;
    return false;
  }


  bool AgendaService::deleteAllMeetings(const std::string &userName){
    int mid=m_storage->deleteMeeting([&](const Meeting meeting)->bool{
        if(meeting.getSponsor()==userName ) return true;
        return false;
    });
    if(mid>0) return true;
    return false;
  }


  void AgendaService::startAgenda(void){
       m_storage=Storage::getInstance();
  }


  void AgendaService::quitAgenda(void){
        m_storage->sync();
  }


