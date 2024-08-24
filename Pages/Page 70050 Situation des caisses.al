page 70050 "Situation des caisses"
{
    LinksAllowed = false;
    PageType = Card;
    SourceTable = 70015;
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {

            group(General)
            {
                Caption = 'General';

                field(Jour; Jour)
                {
                    Caption = 'Date';
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetFilter(dateFilter, '=%1', Jour);
                        fd1 := 0;
                        fd2 := 0;
                        overture1.Reset();
                        overture2.Reset();
                        overture1.SetRange("Date ouverture", Jour);
                        overture2.SetRange("Date ouverture", Jour);
                        overture1.SetRange("Code caisse", 'CAISSE1');
                        overture2.SetRange("Code caisse", 'CAISSE2');
                        if overture1.FindFirst() then begin
                            if overture1.Billetage then begin
                                overture1.CalcFields(Amount);
                                fd1 := overture1.Amount;
                            end else
                                fd1 := overture1.Amount2;

                        end;
                        if overture2.FindFirst() then begin
                            if overture2.Billetage then begin
                                overture2.CalcFields(Amount);
                                fd2 := overture2.Amount;
                            end else
                                fd2 := overture2.Amount2;

                        end;
                        CurrPage.Update();
                    end;
                }
            }
            group(Control1904305601)
            {
                Caption = 'Situation des caisses';
                fixed(Control1904230801)
                {
                    ShowCaption = false;
                    group("Caisse 1")
                    {
                        Caption = '                              CAISSE 1';
                        field(overture1; fd1)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'FOND DE CAISSE';
                            Style = Strong;
                        }
                        //Encaissements
                        field(encaissementCaisse1; encaissementCaisse1)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'TOTAL ENCAISSEMENT';
                            Style = StrongAccent;
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Encaissement;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                if enc.FindFirst() then begin
                                    Page.Run(70056, enc);
                                end;
                            end;
                        }
                        field(encaissementEspeceCaisse1; encaissementEspeceCaisse1)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Encaissement espèces';

                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Encaissement;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange("Mode de paiement", 'ESPÈCES');
                                if enc.FindFirst() then begin
                                    Page.Run(70056, enc);
                                end;
                            end;
                        }
                        field(encaissementCHEQUECaisse1; encaissementCHEQUECaisse1)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Encaissement chèques';

                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Encaissement;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange("Mode de paiement", 'CHEQUE');
                                if enc.FindFirst() then begin
                                    Page.Run(70056, enc);
                                end;
                            end;
                        }
                        field(encaissementVirementCaisse1; encaissementVirementCaisse1)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Encaissement virement';

                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Encaissement;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange("Mode de paiement", 'VIREMENT');
                                if enc.FindFirst() then begin
                                    Page.Run(70056, enc);
                                end;
                            end;
                        }
                        field(encaissementDépotsCaisse1; encaissementDepotCaisse1)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Encaissement Dépôts';

                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange("Mode de reglement", 'EPARGNE');
                                enc.SetRange(recouvrement, false);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        //Recouvrement
                        field(Recouvrementcaisse1; Recouvrementcaisse1)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'TOTAL RECOUVREMENT';
                            Style = StrongAccent;

                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange(source, enc.Source::Facture);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(Recouvrementespececaisse1; Recouvrementespececaisse1)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Recouvrement espèce';


                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange("Mode de reglement", 'ESPÈCES');
                                enc.SetRange(source, enc.Source::Facture);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(Recouvrementdepotcaisse1; Recouvrementdepotcaisse1)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Recouvrement dépôt';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange("Mode de reglement", 'EPARGNE');
                                enc.SetRange(source, enc.Source::Facture);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(Recouvrementchequecaisse1; RecouvrementCHEQUEcaisse1)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Recouvrement chèque';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange("Mode de reglement", 'CHEQUE');
                                enc.SetRange(source, enc.Source::Facture);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(Recouvrementvirementcaisse1; Recouvrementvirementcaisse1)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Recouvrement virement';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::Facture);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange("Mode de reglement", 'VIREMENT');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }

                        //Dépots
                        field(depotCasse1; depotCaisse1)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'TOTAL DEPOTS';
                            Style = StrongAccent;
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::Depot);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(depotEspeceCaisse1; depotEspeceCaisse1)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Dépôts espèces';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::Depot);
                                enc.SetRange("Mode de reglement", 'ESPÈCES');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(depotChequeCaisse1; depotChequeCaisse1)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Dépôts chèques';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::Depot);
                                enc.SetRange("Mode de reglement", 'CHEQUE');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(depotVirementCaisse1; depotVirementCaisse1)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Dépôts virement';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::Depot);
                                enc.SetRange("Mode de reglement", 'VIREMENT');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        // Mouvements
                        field(entreeCaisse1; entreeCaisse1)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'ENTREES';
                            Style = StrongAccent;
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::"E/S");
                                // enc.SetRange("Mode de reglement",'ESPÈCES');
                                enc.setFilter(Montant, '>0');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(sortieCaisse1; sortieCaisse1)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'SORTIES';
                            Style = StrongAccent;

                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::"E/S");
                                //enc.SetRange("Mode de reglement",'ESPÈCES');
                                enc.setFilter(Montant, '<0');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field("Espece attendu caisse1"; "Espece attendu caisse1")
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Espèce attendu';
                            Style = Favorable;
                        }
                        field("Montant declare caisse1"; "Montant declare caisse1")
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Espèce déclaré';
                            Style = Strong;
                        }
                        field("Ecart1"; "Montant declare caisse1" - "Espece attendu caisse1")
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Ecart';
                            Style = Unfavorable;
                        }
                    }
                    group("Caisse 2")


                    {
                        Caption = '                           CAISSE 2';
                        field("Fond de caisse2"; fd2)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'FOND DE CAISSE';
                            Style = Strong;
                        }
                        //Encaissements
                        field(encaissementCaisse2; encaissementCaisse2)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'TOTAL ENCAISSEMENT';
                            Style = StrongAccent;
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Encaissement;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE2');
                                enc.SetRange(Date, Jour);
                                if enc.FindFirst() then begin
                                    Page.Run(70056, enc);
                                end;
                            end;
                        }
                        field(encaissementEspeceCaisse2; encaissementEspeceCaisse2)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Encaissement espèces';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Encaissement;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE2');
                                enc.SetRange(Date, Jour);
                                enc.SetRange("Mode de paiement", 'ESPÈCES');
                                if enc.FindFirst() then begin
                                    Page.Run(70056, enc);
                                end;
                            end;
                        }
                        field(encaissementCHEQUECaisse2; encaissementCHEQUECaisse2)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Encaissement chèques';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Encaissement;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE2');
                                enc.SetRange(Date, Jour);
                                enc.SetRange("Mode de paiement", 'CHEQUE');
                                if enc.FindFirst() then begin
                                    Page.Run(70056, enc);
                                end;
                            end;
                        }
                        field(encaissementVirementCaisse2; encaissementVirementCaisse2)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Encaissement virement';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Encaissement;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE2');
                                enc.SetRange(Date, Jour);
                                enc.SetRange("Mode de paiement", 'VIREMENT');
                                if enc.FindFirst() then begin
                                    Page.Run(70056, enc);
                                end;
                            end;
                        }
                        field(encaissementDépotsCaisse2; encaissementDepotCaisse2)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Encaissement Dépôts';

                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE2');
                                enc.SetRange(Date, Jour);
                                enc.SetRange("Mode de reglement", 'EPARGNE');
                                enc.SetRange(recouvrement, false);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }

                        //Recouvrement
                        field(Recouvrementcaisse2; Recouvrementcaisse2)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'TOTAL RECOUVREMENT';
                            Style = StrongAccent;

                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE2');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange(source, enc.Source::Facture);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(Recouvrementespececaisse2; Recouvrementespececaisse2)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Recouvrement espèce';


                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE2');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange("Mode de reglement", 'ESPÈCES');
                                enc.SetRange(source, enc.Source::Facture);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(Recouvrementdepotcaisse2; Recouvrementdepotcaisse2)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Recouvrement dépôt';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE2');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange("Mode de reglement", 'EPARGNE');
                                enc.SetRange(source, enc.Source::Facture);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(Recouvrementchequecaisse2; RecouvrementCHEQUEcaisse2)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Recouvrement chèque';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE2');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange("Mode de reglement", 'CHEQUE');
                                enc.SetRange(source, enc.Source::Facture);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(Recouvrementvirementcaisse2; Recouvrementvirementcaisse2)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Recouvrement virement';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE2');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange("Mode de reglement", 'VIREMENT');
                                enc.SetRange(source, enc.Source::Facture);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }

                        //Dépots
                        field(depotCasse2; depotCaisse2)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'TOTAL DEPOTS';
                            Style = StrongAccent;
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE2');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::Depot);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(depotEspeceCaisse2; depotEspeceCaisse2)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Dépôts espèces';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE2');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::Depot);
                                enc.SetRange("Mode de reglement", 'ESPÈCES');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(depotChequeCaisse2; depotChequeCaisse2)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Dépôts chèques';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE2');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::Depot);
                                enc.SetRange("Mode de reglement", 'CHEQUE');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(depotVirementCaisse2; depotVirementCaisse2)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Dépôts virement';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE2');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::Depot);
                                enc.SetRange("Mode de reglement", 'VIREMENT');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        // Mouvements
                        field(entreeCaisse2; entreeCaisse2)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'ENTREES';
                            Style = StrongAccent;
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE2');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::"E/S");
                                // enc.SetRange("Mode de reglement",'ESPÈCES');
                                enc.setFilter(Montant, '<0');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(sortieCaisse2; sortieCaisse2)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'SORTIES';
                            Style = StrongAccent;
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE2');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::"E/S");
                                //enc.SetRange("Mode de reglement",'ESPÈCES');
                                enc.setFilter(Montant, '<0');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field("Espece attendu caisse2"; "Espece attendu caisse2")
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Espèce attendu';
                            Style = Favorable;
                        }
                        field("Montant declare caisse2"; "Montant declare caisse2")
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Espèce déclaré';
                            Style = Strong;
                        }
                        field("Ecart2"; "Montant declare caisse2" - "Espece attendu caisse2")
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Ecart';
                            Style = Unfavorable;
                        }

                    }


                    group("Caisse 3")


                    {
                        Caption = '                           CAISSE 3';
                        field("Fond de caisse3"; fd3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'FOND DE CAISSE';
                            Style = Strong;
                        }
                        //Encaissements
                        field(encaissementCaisse3; encaissementCaisse3)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'TOTAL ENCAISSEMENT';
                            Style = StrongAccent;
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Encaissement;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE3');
                                enc.SetRange(Date, Jour);
                                if enc.FindFirst() then begin
                                    Page.Run(70056, enc);
                                end;
                            end;
                        }
                        field(encaissementEspeceCaisse3; encaissementEspeceCaisse3)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Encaissement espèces';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Encaissement;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE3');
                                enc.SetRange(Date, Jour);
                                enc.SetRange("Mode de paiement", 'ESPÈCES');
                                if enc.FindFirst() then begin
                                    Page.Run(70056, enc);
                                end;
                            end;
                        }
                        field(encaissementCHEQUECaisse3; encaissementCHEQUECaisse3)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Encaissement chèques';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Encaissement;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE3');
                                enc.SetRange(Date, Jour);
                                enc.SetRange("Mode de paiement", 'CHEQUE');
                                if enc.FindFirst() then begin
                                    Page.Run(70056, enc);
                                end;
                            end;
                        }
                        field(encaissementVirementCaisse3; encaissementVirementCaisse3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Encaissement virement';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Encaissement;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE3');
                                enc.SetRange(Date, Jour);
                                enc.SetRange("Mode de paiement", 'VIREMENT');
                                if enc.FindFirst() then begin
                                    Page.Run(70056, enc);
                                end;
                            end;
                        }
                        field(encaissementDépotsCaisse3; encaissementDepotCaisse3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Encaissement Dépôts';

                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE3');
                                enc.SetRange(Date, Jour);
                                enc.SetRange("Mode de reglement", 'EPARGNE');
                                enc.SetRange(recouvrement, false);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }

                        //Recouvrement
                        field(Recouvrementcaisse3; Recouvrementcaisse3)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'TOTAL RECOUVREMENT';
                            Style = StrongAccent;

                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE3');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange(source, enc.Source::Facture);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(Recouvrementespececaisse3; Recouvrementespececaisse3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Recouvrement espèce';


                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE3');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange("Mode de reglement", 'ESPÈCES');
                                enc.SetRange(source, enc.Source::Facture);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(Recouvrementdepotcaisse3; Recouvrementdepotcaisse3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Recouvrement dépôt';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE3');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange("Mode de reglement", 'EPARGNE');
                                enc.SetRange(source, enc.Source::Facture);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(Recouvrementchequecaisse3; RecouvrementCHEQUEcaisse3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Recouvrement chèque';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE3');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange("Mode de reglement", 'CHEQUE');
                                enc.SetRange(source, enc.Source::Facture);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(Recouvrementvirementcaisse3; Recouvrementvirementcaisse3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Recouvrement virement';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE3');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange("Mode de reglement", 'VIREMENT');
                                enc.SetRange(source, enc.Source::Facture);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }

                        //Dépots
                        field(depotCasse3; depotCaisse3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'TOTAL DEPOTS';
                            Style = StrongAccent;
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE3');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::Depot);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(depotEspeceCaisse3; depotEspeceCaisse3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Dépôts espèces';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE3');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::Depot);
                                enc.SetRange("Mode de reglement", 'ESPÈCES');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(depotChequeCaisse3; depotChequeCaisse3)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Dépôts chèques';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE3');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::Depot);
                                enc.SetRange("Mode de reglement", 'CHEQUE');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(depotVirementCaisse3; depotVirementCaisse3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Dépôts virement';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE3');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::Depot);
                                enc.SetRange("Mode de reglement", 'VIREMENT');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        // Mouvements
                        field(entreeCaisse3; entreeCaisse3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'ENTREES';
                            Style = StrongAccent;
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE3');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::"E/S");
                                // enc.SetRange("Mode de reglement",'ESPÈCES');
                                enc.setFilter(Montant, '<0');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(sortieCaisse3; sortieCaisse3)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'SORTIES';
                            Style = StrongAccent;
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE3');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::"E/S");
                                //enc.SetRange("Mode de reglement",'ESPÈCES');
                                enc.setFilter(Montant, '<0');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field("Espece attendu caisse3"; "Espece attendu caisse3")
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Espèce attendu';
                            Style = Favorable;
                        }
                        field("Montant declare caisse3"; "Montant declare caisse3")
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Espèce déclaré';
                            Style = Strong;
                        }
                        field("Ecart3"; "Montant declare caisse3" - "Espece attendu caisse3")
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Ecart';
                            Style = Unfavorable;
                        }

                    }

                    group("Total")
                    {
                        Caption = '                               TOTAL';
                        field("Fond de caisse"; fd1 + fd2 + fd3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'FOND DE CAISSE';
                            Style = Strong;
                        }
                        //Encaissements
                        field(encaissementCaisse; encaissementCaisse2 + encaissementCaisse1 + encaissementCaisse3)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'TOTAL ENCAISSEMENTS';
                            Style = StrongAccent;
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Encaissement;
                            begin
                                //enc.SetRange("Code caisse", 'CAISSE1');

                                enc.SetRange(Date, Jour);
                                enc.SetFilter(Montant, '<>0');
                                if enc.FindFirst() then begin
                                    Page.Run(70056, enc);
                                end;
                            end;
                        }
                        field(encaissementEspeceCaisse; encaissementEspeceCaisse2 + encaissementEspeceCaisse1 + encaissementEspeceCaisse3)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Encaissement espèces';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Encaissement;
                            begin
                                //enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange("Mode de paiement", 'ESPÈCES');
                                if enc.FindFirst() then begin
                                    Page.Run(70056, enc);
                                end;
                            end;
                        }
                        field(encaissementCHEQUECaisse; encaissementCHEQUECaisse2 + encaissementCHEQUECaisse1 + encaissementCHEQUECaisse3)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Encaissement chèques';

                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Encaissement;
                            begin
                                //enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange("Mode de paiement", 'CHEQUE');
                                if enc.FindFirst() then begin
                                    Page.Run(70056, enc);
                                end;
                            end;
                        }
                        field(encaissementVirementCaisse; encaissementVirementCaisse2 + encaissementVirementCaisse1 + encaissementVirementCaisse3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Encaissement virement';

                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Encaissement;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange("Mode de paiement", 'VIREMENT');
                                if enc.FindFirst() then begin
                                    Page.Run(70056, enc);
                                end;
                            end;
                        }
                        field(encaissementDepotCaisse; encaissementDepotCaisse1 + encaissementDepotCaisse2 + encaissementDepotCaisse3)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Encaissement dépôts';

                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                //enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange("Mode de reglement", 'EPARGNE');
                                enc.SetRange(recouvrement, false);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        //Recouvrement


                        field(Recouvrement; Recouvrementcaisse1 + Recouvrementcaisse2 + Recouvrementcaisse3)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'TOTAL RECOUVREMENT';
                            Style = StrongAccent;

                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                //enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange(source, enc.Source::Facture);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(Recouvrementespece; Recouvrementespececaisse1 + Recouvrementespececaisse2 + Recouvrementespececaisse3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Recouvrement espèce';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                //enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange("Mode de reglement", 'ESPÈCES');
                                enc.SetRange(source, enc.Source::Facture);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(Recouvrementdepot; Recouvrementdepotcaisse1 + Recouvrementdepotcaisse2 + Recouvrementdepotcaisse3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Recouvrement dépôt';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                // enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange("Mode de reglement", 'EPARGNE');
                                enc.SetRange(source, enc.Source::Facture);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(Recouvrementcheque; RecouvrementCHEQUEcaisse1 + RecouvrementCHEQUEcaisse2 + RecouvrementCHEQUEcaisse3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Recouvrement chèque';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                //enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange("Mode de reglement", 'CHEQUE');
                                enc.SetRange(source, enc.Source::Facture);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(Recouvrementvirement; Recouvrementvirementcaisse1 + Recouvrementvirementcaisse2 + Recouvrementvirementcaisse3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Recouvrement virement';

                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                //enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::Facture);
                                enc.SetRange(recouvrement, true);
                                enc.SetRange("Mode de reglement", 'VIREMENT');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        //Dépots
                        field(depotCaisse; depotCaisse2 + depotCaisse1 + depotCaisse3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'TOTAL DEPOTS';
                            Style = StrongAccent;
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                //enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::Depot);
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(depotEspeceCaisse; depotEspeceCaisse2 + depotEspeceCaisse1 + depotEspeceCaisse3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Dépôts espèces';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                //enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::Depot);
                                enc.SetRange("Mode de reglement", 'ESPÈCES');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(depotChequeCaisse; depotChequeCaisse2 + depotChequeCaisse1 + depotChequeCaisse3)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Dépôts chèques';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                //enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::Depot);
                                enc.SetRange("Mode de reglement", 'CHEQUE');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(depotVirementCaisse; depotVirementCaisse2 + depotVirementCaisse1 + depotVirementCaisse3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'Dépôts virement';
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                //enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::Depot);
                                enc.SetRange("Mode de reglement", 'VIREMENT');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        // Mouvements
                        field(entreeCaisse; entreeCaisse2 + entreeCaisse1 + entreeCaisse3)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'ENTREES';
                            Style = StrongAccent;
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                //enc.SetRange("Code caisse", 'CAISSE2');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::"E/S");
                                //enc.SetRange("Mode de reglement",'ESPÈCES');
                                enc.setFilter(Montant, '>0');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;
                        }
                        field(sortieCaisse; sortieCaisse2 + sortieCaisse1 + sortieCaisse3)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'SORTIES';
                            Style = StrongAccent;
                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Transactions;
                            begin
                                //enc.SetRange("Code caisse", 'CAISSE2');
                                enc.SetRange(Date, Jour);
                                enc.SetRange(source, enc.Source::"E/S");
                                //enc.SetRange("Mode de reglement",'ESPÈCES');
                                enc.setFilter(Montant, '<0');
                                if enc.FindFirst() then begin
                                    Page.Run(70057, enc);
                                end;
                            end;

                        }
                        field("Espece attendu"; "Espece attendu caisse1" + "Espece attendu caisse2" + "Espece attendu caisse3")
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Espèce attendu';
                            Style = Favorable;
                        }
                        field("Montant declare"; "Montant declare caisse1" + "Montant declare caisse2" + "Montant declare caisse3")
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Espèce déclaré';
                            Style = Strong;
                        }
                        field("Ecart total"; ("Montant declare caisse1" + "Montant declare caisse2" + "Montant declare caisse3") -
                        ("Espece attendu caisse1" + "Espece attendu caisse2" + "Espece attendu caisse3"))
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Ecart';
                            Style = Unfavorable;
                        }

                    }

                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
    begin
        if NOT GET then begin
            Init();
            Insert();
            CurrPage.Update();
        end;
        CurrPage.Update();
        Jour := WorkDate();
        SetFilter(dateFilter, '=%1', Jour);
        SetFilter(montangFilter1, '>0');
        SetFilter(montangFilter2, '<0');

        CurrPage.Update();
        fd1 := 0;
        fd2 := 0;
        fd3 := 0;
        overture1.Reset();
        overture2.Reset();
        overture3.Reset();
        overture1.SetRange("Date ouverture", Jour);
        overture2.SetRange("Date ouverture", Jour);
        overture3.SetRange("Date ouverture", Jour);
        overture1.SetRange("Code caisse", 'CAISSE1');
        overture2.SetRange("Code caisse", 'CAISSE2');
        overture3.SetRange("Code caisse", 'CAISSE3');
        if overture1.FindFirst() then begin
            if overture1.Billetage then begin
                overture1.CalcFields(Amount);
                fd1 := overture1.Amount;
            end else
                fd1 := overture1.Amount2;

        end;
        if overture2.FindFirst() then begin
            if overture2.Billetage then begin
                overture2.CalcFields(Amount);
                fd2 := overture2.Amount;
            end else
                fd2 := overture2.Amount2;

        end;

        if overture3.FindFirst() then begin
            if overture3.Billetage then begin
                overture3.CalcFields(Amount);
                fd3 := overture3.Amount;
            end else
                fd3 := overture3.Amount2;

        end;

    end;

    trigger OnAfterGetRecord()
    var

    begin

    end;

    var
        overture1: Record "Ouverture de caisse";
        overture2: Record "Ouverture de caisse";
        overture3: Record "Ouverture de caisse";
        fd1: Decimal;
        fd2: Decimal;
        fd3: Decimal;
        Jour: Date;

}