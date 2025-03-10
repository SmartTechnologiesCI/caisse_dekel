page 70035 CaisseActivity
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Caisse Cue";

    layout
    {
        area(Content)
        {
            cuegroup("Factures en attente de paiement")
            {
                field("Factures pécommandées"; rec."Factures pécommandées")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = false;
                    trigger OnDrillDown()
                    var
                        factureJour: Record "Sales Invoice Header";
                    begin
                        factureJour.setFilter("Order Date", '>%1', WorkDate());
                        factureJour.SetRange(Closed, false);
                        factureJour.FindFirst();
                        Page.RunModal(Page::"Liste des factures", factureJour);
                    end;
                }
                field("Factures du jour"; rec."Factures du jour")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        factureJour: Record "Sales Invoice Header";
                    begin
                        factureJour.SetRange("Order Date", WorkDate);
                        factureJour.SetRange(Closed, false);
                        factureJour.SetRange(CreditP, false);
                        factureJour.FindFirst();
                        Page.RunModal(Page::"Liste des factures", factureJour);
                    end;
                }
                field("Factures anterieures"; rec."Factures anterieures")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        factureJour: Record "Sales Invoice Header";
                    begin
                        factureJour.SetFilter("Order Date", '<%1', WorkDate);
                        factureJour.SetRange(Closed, false);
                        factureJour.FindFirst();
                        Page.RunModal(Page::"Liste des factures", factureJour);
                    end;
                }
            }
            cuegroup("Crédist&Dépots")
            {
                Caption = 'Crédits & Dépôts';
                field("Factures à crédit"; rec."Factures à crédit")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        factureJour: Record "Sales Invoice Header";
                    begin
                        factureJour.SetRange(CreditP, true);
                        factureJour.SetFilter("Remaining Amount", '>0');
                        factureJour.SetRange(Closed, false);
                        factureJour.FindFirst();
                        Page.RunModal(Page::"Liste des factures", factureJour);
                    end;
                }
                field("Depots du jour"; rec."Depots du jour")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        DepotJour: Record "Depôt";
                    begin
                        DepotJour.SetRange(Date, WorkDate);
                        DepotJour.SetRange("Code Caisse", caisse."Code caisse");
                        DepotJour.SetFilter(Montant, '>%1', 0);
                        Page.RunModal(Page::"Dépôts", DepotJour);
                    end;
                }
            }
            cuegroup("Comptes de tiers")
            {
                Caption = 'APPROBATIONS DEPOT';
                // field(debiteur; rec.debiteur)
                // {
                //     Caption = 'Nos débiteurs';
                //     ApplicationArea = All;
                //     DrillDown = true;
                //     Image = Cash;

                //     trigger OnDrillDown()
                //     var
                //         customer: Record Customer;
                //     begin
                //         customer.SetFilter("Balance Due", '>%1', 0);
                //         customer.FindFirst();
                //         Page.RunModal(Page::"Liste des Clients", customer);
                //     end;
                // }
                /*field(crediteur; crediteur)
                {
                    Caption = 'Nos créditeurs';
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        customer: Record Customer;
                    begin
                        customer.SetFilter("Balance Due", '<%1', 0);
                        customer.FindFirst();
                        Page.RunModal(Page::"Liste des Clients", customer);
                    end;
                }*/

                /*      field("Depots Actifs"; rec."Depots Actifs")
                      {
                          Caption = 'Dépôts actifs';
                          ApplicationArea = All;
                          DrillDown = true;
                          trigger OnDrillDown()
                          var
                              customer: Record Customer;
                          begin
                              customer.SetFilter("Dépôts", '>%1', 0);
                              customer.FindFirst();
                              Page.RunModal(70051, customer);
                          end;
                      }*/

                field(DepotsCorrectionAttente; rec.DepotsCorrectionAttente)
                {
                    Caption = 'Dépôts en attente';
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        DepotJour: Record "Depôt";
                    begin
                        DepotJour.SetRange("Code Caisse", caisse."Code caisse");
                        // 07/03/2025 DepotJour.SetRange(DemandeApprobation, true);
                        DepotJour.SetRange(Correction, false);
                        DepotJour.SetRange(validated, false);
                        Page.RunModal(Page::"Dépôts", DepotJour);
                    end;
                }

                field(DepotsCorrectionApprou; rec.DepotsCorrectionApprou)
                {
                    Caption = 'Dépôts Approuvés';
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        DepotJour: Record "Depôt";
                    begin
                        DepotJour.SetRange("Code Caisse", caisse."Code caisse");
                        // silue samuel 07/03/2025 DepotJour.SetRange(DemandeApprobation, true);
                        DepotJour.SetRange(Correction, true);
                        DepotJour.SetRange(validated, false);
                        Page.RunModal(Page::"Dépôts", DepotJour);
                    end;
                }



            }

            cuegroup("Duplicata")
            {
                Caption = 'Duplicata reçu';
                // field(debiteur; rec.debiteur)
                // {
                //     Caption = 'Nos débiteurs';
                //     ApplicationArea = All;
                //     DrillDown = true;
                //     Image = Cash;

                //     trigger OnDrillDown()
                //     var
                //         customer: Record Customer;
                //     begin
                //         customer.SetFilter("Balance Due", '>%1', 0);
                //         customer.FindFirst();
                //         Page.RunModal(Page::"Liste des Clients", customer);
                //     end;
                // }
                /*field(crediteur; crediteur)
                {
                    Caption = 'Nos créditeurs';
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        customer: Record Customer;
                    begin
                        customer.SetFilter("Balance Due", '<%1', 0);
                        customer.FindFirst();
                        Page.RunModal(Page::"Liste des Clients", customer);
                    end;
                }*/

                /*      field("Depots Actifs"; rec."Depots Actifs")
                      {
                          Caption = 'Dépôts actifs';
                          ApplicationArea = All;
                          DrillDown = true;
                          trigger OnDrillDown()
                          var
                              customer: Record Customer;
                          begin
                              customer.SetFilter("Dépôts", '>%1', 0);
                              customer.FindFirst();
                              Page.RunModal(70051, customer);
                          end;
                      }*/



                // silue samuel 07/03/2025  field(DuplicataAttente; rec.DuplicataAttente)
                // {
                //     Caption = 'Duplicata en attente';
                //     ApplicationArea = All;
                //     DrillDown = true;
                //     trigger OnDrillDown()
                //     var
                //         DepotJour: Record "Sales Invoice Header";
                //     begin

                //         // DepotJour.SetRange("Demande approbation", true);
                //         DepotJour.SetRange(Approuve, false);
                //         Page.RunModal(Page::"Liste des factures", DepotJour);
                //     end;
                // }

                field(DuplicataApprou; rec.DuplicataApprou)
                {
                    Caption = 'Duplicata Approuvés';
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        DepotJour: Record "Sales Invoice Header";
                    begin

                        // DepotJour.SetRange(Approuve, true);
                        // Page.RunModal(Page::"Liste des factures", DepotJour);
                    end;
                }
            }
            cuegroup("Statistiques journalières")
            {
                CuegroupLayout = wide;
                Caption = 'Statistiques journalières';
                field("Total entrées du jours"; rec."Total entrées du jours")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        mvtJour: Record "Mouvements Entrees Sorties";
                    begin
                        mvtJour.SetRange(Date, WorkDate);
                        mvtJour.SetRange(type, mvtJour.type::Entree);
                        mvtJour.SetRange("Code Caisse", caisse."Code caisse");
                        Page.RunModal(Page::"Mouvements Entrées et sorties", mvtJour);
                    end;
                }
                field("Total sorties du jours"; rec."Total sorties du jours")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        mvtJour: Record "Mouvements Entrees Sorties";
                    begin
                        mvtJour.SetRange(Date, WorkDate);
                        mvtJour.SetRange(type, mvtJour.type::Sortie);
                        mvtJour.SetRange("Code Caisse", caisse."Code caisse");
                        Page.RunModal(Page::"Mouvements Entrées et sorties", mvtJour);
                    end;
                }
            }
        }
    }

    actions
    {

    }
    trigger OnOpenPage()
    begin
        caisse.Reset();
        caisse.SetRange("User ID", UserId);
        caisse.FindFirst();
        if not Get() then begin
            Init();
            Insert();
            CurrPage.Update();
        end;
        SetFilter("Date Filter", '=%1', WorkDate);
        SetFilter("caisse filter", '=%1', caisse."Code caisse");
        SetFilter("date filter 2", '<%1', WorkDate);
        SetFilter("date filter 3", '>%1', WorkDate);
        SetFilter(balanceFilter, '>%1', 0);
        SetFilter(balanceFilter2, '<%1', 0);
    end;

    trigger OnAfterGetRecord()
    var
        ouverture: Record "Ouverture de caisse";
    begin
        caisse.Reset();
        caisse.SetRange("User ID", UserId);
        caisse.FindFirst();
        ouverture.Reset();
        ouverture.SetRange("Code caisse", caisse."Code caisse");
        ouverture.SetFilter(status, '=%1|%2', ouverture.status::Opened, ouverture.status::Validated);
        ouverture.SetFilter("Date ouverture", '<%1', WorkDate);
        if (ouverture.FindFirst()) then begin
            Message('Veuillez clôturer le point de caisse précédent avant de continuer');
        end;
    end;

    var
        caisse: Record Caisse;
}