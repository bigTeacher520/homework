//#include <string>
#include "User.hpp"

User::User(const std::string &t_userName, const std::string &t_userPassword,const std::string &t_userEmail, const std::string &t_userPhone){
		this->m_name=t_userName;
		this->m_password=t_userPassword;
		this->m_email=t_userEmail;
		this->m_phone=t_userPhone;
	}
User:: User(const User& t_user){
    this->m_name=t_user.getName();
    this->m_password=t_user.getPassword();
    this->m_email=t_user.getEmail();
    this->m_phone=t_user.getPhone();
}
std::string User::getName() const{
		return this->m_name;
	}
void User::setName(const std::string &name){
		this->m_name=name;
	}
std::string User::getPassword() const{
		return this->m_password;
	}
void User::setPassword(const std::string &password){
		this->m_password=password;
	}
std::string User::getEmail() const{
		return this->m_email;
	}
void User::setEmail(const std::string& email){
		this->m_email=email;
	}
std::string User::getPhone() const{
		return this->m_phone;
	}
void User::setPhone(const std::string &t_phone){
		this->m_phone=t_phone;
	}

