# language: ro

Functionalitate: Ciclu de viata al unui eveniment
	Un eveniment poate avea urmatorul ciclu de viata: 
		1. Opening - e starea default dupa crearea evenimentului
		2. Evaluating (conditional) - daca evenimentul este creat de un client, atunci acesta va trebui evaluat de catre un admin user
		3. Debugging (diagnoza) (conditional) - starea evenimentului atunci cand nu se cunoaste cauza defectului de la inceput si se trece din open in debugging atunci cand utlizatorul admin doreste asta
		4. Solving - starea evenimentului dupa ce s-a aflat prin diagnoza sau deja se stia cauza defectului si se aplica rezolvarea (schimbarea piesei defecte, efectuarea reglajului, s.a.m.d)
		5. Closed - starea finala dupa ce rezolvarea a luat sfarsit
	Un eveniment se poate redeschide daca simptomele sunt aceleasi si rezolvarea initiala nu a facut decat sa amelioreze sau sa ascunda defectul pt o anumita perioada de timp. La redeschiderea evenimentului utlizatorul admin va trebui sa aleaga daca va trebui diagnoza pt gasirea solutiei sau se trece direct la aplicarea unei noi rezolvari.

Context: 
	Dat fiind ca sunt sunt admin
	Si sunt autentificat

Scenariu: Deschiderea unui eveniment nou (opening) caruia nu-i stiu rezolvarea
	Dat fiind ca sunt pe pagina de creare a unui eveniment nou
	Si completez forumularul cu date corecte 
	Si aleg ca urmatorul pas sa fie diagnoza(debugging)
	Atunci primesc un email de confirmare ca evenimentul a fost creat
	Si pe pagina unde am fost redirectionat ar trebui sa vad butonul "Evalueaza"

Scenariu: Diagnoza unui eveniment (diagnosing)
	Dat fiind ca sunt pe pagina de diagnoza a evenimentului
	Si introduc fiecare pas efectuat pt gasirea diagnosticului
	Cand am gasit diagnosticul si inchid diagnoza
	Atunci aleg pasul ce a dus la rezolvare
	Si aleg tipul de problema (mecanica, electrica, soft, s.a.m.d)
	Si definesc componenta cu pricina
	Atunci evenimentul este diagnosticat (debugged)
	Si urmatorul pas trebuie sa fie rezolvarea

Scenariu: Rezolvarea unui eveniment (solving)
	Dat fiind Ca sunt pe pagina de rezolvare a unui eveniment
	Cand completez ce a dus la rezolvarea problemei
	Atunci evenimentul solved si trece in starea solved


