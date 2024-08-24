page 70060 "0000Pages"
{
    LinksAllowed = false;
    PageType = Card;
    SourceTable = "situation caisse Control";
    DeleteAllowed = false;
    InsertAllowed = false;
    UsageCategory = Administration;
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
                                enc: Record Encaissement;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange("Mode de paiement", 'EPARGNE');
                                if enc.FindFirst() then begin
                                    Page.Run(70056, enc);
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
                                enc.setFilter(Montant, '=%1', montangFilter2);
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
                                enc: Record Encaissement;
                            begin
                                enc.SetRange("Code caisse", 'CAISSE2');
                                enc.SetRange(Date, Jour);
                                enc.SetRange("Mode de paiement", 'EPARGNE');
                                if enc.FindFirst() then begin
                                    Page.Run(70056, enc);
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
                        field("Ecart"; "Montant declare caisse2" - "Espece attendu caisse2")
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Ecart';
                            Style = Unfavorable;
                        }

                    }
                    group("Total")
                    {
                        Caption = '                               TOTAL';
                        field("Fond de caisse"; fd1 + fd2)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'FOND DE CAISSE';
                            Style = Strong;
                        }
                        //Encaissements
                        field(encaissementCaisse; encaissementCaisse2 + encaissementCaisse1)
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
                                if enc.FindFirst() then begin
                                    Page.Run(70033, enc);
                                end;
                            end;
                        }
                        field(encaissementEspeceCaisse; encaissementEspeceCaisse2 + encaissementEspeceCaisse1)
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
                                    Page.Run(70033, enc);
                                end;
                            end;
                        }
                        field(encaissementCHEQUECaisse; encaissementCHEQUECaisse2 + encaissementCHEQUECaisse1)
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
                                    Page.Run(70033, enc);
                                end;
                            end;
                        }
                        field(encaissementVirementCaisse; encaissementVirementCaisse2 + encaissementVirementCaisse1)
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
                                    Page.Run(70033, enc);
                                end;
                            end;
                        }
                        field(encaissementDepotCaisse; encaissementDepotCaisse1 + encaissementDepotCaisse2)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Encaissement dépôts';

                            DrillDown = true;
                            trigger OnDrillDown()
                            var
                                enc: Record Encaissement;
                            begin
                                //enc.SetRange("Code caisse", 'CAISSE1');
                                enc.SetRange(Date, Jour);
                                enc.SetRange("Mode de paiement", 'EPARGNE');
                                if enc.FindFirst() then begin
                                    Page.Run(70033, enc);
                                end;
                            end;
                        }
                        //Recouvrement


                        field(Recouvrement; Recouvrementcaisse1 + Recouvrementcaisse2)
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
                        field(Recouvrementespece; Recouvrementespececaisse1 + Recouvrementespececaisse2)
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
                        field(Recouvrementdepot; Recouvrementdepotcaisse1 + Recouvrementdepotcaisse2)
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
                        field(Recouvrementcheque; RecouvrementCHEQUEcaisse1 + RecouvrementCHEQUEcaisse1)
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
                        field(Recouvrementvirement; Recouvrementvirementcaisse1 + Recouvrementvirementcaisse2)
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
                        field(depotCaisse; depotCaisse2 + depotCaisse1)
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
                        field(depotEspeceCaisse; depotEspeceCaisse2 + depotEspeceCaisse1)
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
                        field(depotChequeCaisse; depotChequeCaisse2 + depotChequeCaisse1)
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
                        field(depotVirementCaisse; depotVirementCaisse2 + depotVirementCaisse1)
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
                        field(entreeCaisse; entreeCaisse2 + entreeCaisse1)
                        {
                            ApplicationArea = Basic, suite;
                            Caption = 'ENTREES';
                            Style = Strong;
                        }
                        field(sortieCaisse; sortieCaisse2 + sortieCaisse1)
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'SORTIES';
                            Style = Strong;

                        }
                        field("Espece attendu"; "Espece attendu caisse1" + "Espece attendu caisse2")
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Espèce attendu';
                            Style = Favorable;
                        }
                        field("Montant declare"; "Montant declare caisse1" + "Montant declare caisse2")
                        {

                            ApplicationArea = Basic, suite;
                            Caption = 'Espèce déclaré';
                            Style = Strong;
                        }
                        field("Ecart total"; ("Montant declare caisse1" + "Montant declare caisse2") - ("Espece attendu caisse1" + "Espece attendu caisse2"))
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

    end;

    trigger OnAfterGetRecord()
    var

    begin

    end;

    var
        overture1: Record "Ouverture de caisse";
        overture2: Record "Ouverture de caisse";
        fd1: Decimal;
        fd2: Decimal;
        Jour: Date;

}