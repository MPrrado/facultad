/*
 * Create.h
 */

#ifndef CREATE_H_
#define CREATE_H_

namespace std {

class crearydestruir
{
	int data;
public:
	crearydestruir(int);	//constructor sobrecargado
	crearydestruir(crearydestruir& aux);	//constructor copia

	~crearydestruir( );		//destructor

};


} /* namespace std */

#endif /* CREATE_H_ */
