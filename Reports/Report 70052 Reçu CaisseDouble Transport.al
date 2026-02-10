report 70052 Recu_Paiement_Double_Transport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Reçu Paiement Transport';
    RDLCLayout = 'Reports\RDLC\Report 70050 Recu Paiement_Double.rdlc';
    dataset
    {
        dataitem("Item Weigh Bridge"; "Item Weigh Bridge")
        {
            RequestFilterFields = NumDocExten;
            column(Ticket_Planteur; "Ticket Planteur")
            {

            }
            column(Date_validation; "Date validation")
            {

            }
            column(Vehicle_Registration_No_; "Vehicle Registration No.")
            {

            }
            column(POIDS_NET; "POIDS NET")
            {

            }
            column(Prix; Prix)
            {

            }
            column(Picture; CompanyInfo.Picture)
            {

            }
            column(Item_Origin; "Item Origin")
            {

            }
            column(Date_Paiement; Date_Paiement)
            {

            }
            column(Concerne; Concerne)
            {

            }
            column(Nom_Concerne; Nom_Concerne)
            {

            }
            column("Type_opération"; "Type opération")
            {

            }
            column(TICKET; TICKET)
            {

            }
            column(Beneficiaire; Beneficiaire)
            {

            }
            column(NCNI; NCNI)
            {

            }
            column(Mode_Paiement; Mode_Paiement)
            {

            }
            column(Observation; Observation)
            {

            }
            column(Telephone; Telephone)
            {

            }
            column(TaxeImpot; TaxeImpot)
            {

            }
            column(Titre; Titre)
            {

            }

            //Centre Logistique
            column(CL; CL)
            {

            }
            column(NumDocExten; NumDocExten)
            {

            }
            column(NumeroDocTransport; NumeroDocTransport)
            {

            }

            //Centre Logistique

            trigger OnPreDataItem()
            var
                TypeOperation: Option;
            begin
                Clear(TicketTransporteur);
                CompanyInfo.get();
                CompanyInfo.CalcFields(Picture);
                TicketTransporteur := true;
                if ((TicketPlanteur = false) and (TicketTransporteur = false)) then begin
                    Error('Choisissez le type de ticket (Soit Planteur soit Transporteur)');
                end else begin
                    if ((TicketPlanteur = true) and (TicketTransporteur = true)) then begin
                        Error('Choisissez un seul ticket');
                    end;
                    if TicketPlanteur = true then begin
                        Concerne := Planteur;
                        Nom_Concerne := "Nom planteur";
                        Titre := 'REGIME';

                        // Message('aaabbbFnGek: %1 Ticket: %2', "Statut paiement Planteur", "Ticket Planteur");
                        // if PrixAchat.FindSet() then begin

                        // end;
                        // PrixAchat.SetRange("Type operation", "Type opération");
                    end else begin
                        if TicketTransporteur = true then begin
                            Concerne := Transporteurname;
                            Nom_Concerne := "Nom planteur";
                            Titre := 'TRANSPORT';
                            //***FnGeek
                            // Message('aaa: %1 bb: %2', "Statut paiement", "Ticket Planteur");
                        end;
                    end;
                end;

            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                VendorSplitTaxSetup: Record "Vendor Split Tax Setup";
                WeightItem: Record "Item Weigh Bridge";
                Caisse: Record Caisse;
            begin

                // if FindFirst() then begin
                //     if "Statut paiement Planteur" = true then begin
                //         TicketPlanteur := true;
                //     end else begin

                //     end;
                // end;
                // /*
                Clear(CL);
                Clear(visiblePlanteur);
                Clear(visibleTransport);
                WeightItem.SetRange("Ticket Planteur", "Ticket Planteur");
                // WeightItem.SetRange(TICKET, TICKET);
                // WeightItem.SetRange("Row No.", "Row No.");
                // WeightItem.SetRange(RowID, RowID);
                if WeightItem.FindFirst() then begin
                    if WeightItem."Statut paiement" = false then begin
                        if TicketTransporteur = true then begin
                            Error('Le transport n''est pas encore payé');
                        end;
                    end;
                    if WeightItem."Statut paiement Planteur" = false then begin
                        if TicketPlanteur = TRUE then begin
                            Error('Le regime n''est pas encore payé');
                        end;
                    end;
                    // Message('aa: %1 bb: %2', WeightItem."Statut paiement", WeightItem."Statut paiement Planteur");
                end;
                // */

                //Centre Logistique
                // Caisse.SetRange("User ID", UserId);
                if FindFirst() then begin
                    CL := CLpaiement;
                end;
                //Centre Logistique

                if TicketPlanteur = true then begin
                    VendorSplitTaxSetup.SetRange("Vendor No.", "Code planteur");
                    if VendorSplitTaxSetup.FindFirst() then begin
                        TaxeImpot := VendorSplitTaxSetup.Percentage / 100;
                        // taxe := (VendorSplitTaxSetup.Percentage / 100);
                    end else begin
                        TaxeImpot := 1;
                    end;
                    Nom_Concerne := "Nom planteur";
                    PrixAchat.setFilter("Purchase Type", '=%1', PrixAchat."Purchase Type"::"Vendor Posting Group");
                    PrixAchat.SetFilter("Item No.", '=%1', 'RPH-9003');
                    PrixAchat.SetFilter("Starting Date", '<=%1', "Weighing 1 Date");
                    PrixAchat.SetFilter("Ending Date", '>=%1', "Weighing 1 Date");
                    PrixAchat.SetRange(Type_Operation_Options, "Type opération");
                    if PrixAchat.FindFirst() then begin
                        VendorSplitTaxSetup.SetRange("Vendor No.", "Code planteur");
                        if VendorSplitTaxSetup.FindFirst() then begin
                            Prix := PrixAchat."Direct Unit Cost" - VendorSplitTaxSetup.Cost;
                            // taxe := (VendorSplitTaxSetup.Percentage / 100);
                        end else begin
                            Message('Prix non trouvé');
                        end;

                    end;
                end else begin
                    if TicketTransporteur = true then begin
                        TaxeImpot := 1;
                        Nom_Concerne := "Nom planteur";
                        PrixAchat.setFilter("Purchase Type", '=%1', PrixAchat."Purchase Type"::"Vendor Posting Group");
                        PrixAchat.SetFilter("Item No.", '=%1', 'TRANSPORT');
                        PrixAchat.SetFilter("Starting Date", '<=%1', "Weighing 1 Date");
                        PrixAchat.SetFilter("Ending Date", '>=%1', "Weighing 1 Date");
                        PrixAchat.SetRange(Type_Operation_Options, "Type opération");
                        if PrixAchat.FindFirst() then begin
                            Prix := PrixAchat."Direct Unit Cost";
                        end;
                    end;
                end;

            end;



        }


    }


    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';

        layout
        {
            area(Content)
            {
                group(Planteur_Trasnporteur)
                {
                    Caption = 'Planteur/Ttansporteur';
                    field(TicketPlanteur; TicketPlanteur)
                    {
                        ApplicationArea = All;
                        Visible = false;
                        // Visible = visiblePlanteur;
                    }
                    field(TicketTransporteur; TicketTransporteur)
                    {
                        ApplicationArea = All;
                        Visible = false;
                        // Visible = visibleTransport;
                    }

                }
            }

        }



        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }
    }



    var
        myInt: Integer;
        Prix: Decimal;
        CompanyInfo: Record "Company Information";
        Planteur: TextConst FRA = 'Planteur';
        Transporteurname: TextConst FRA = 'Transporteur';
        Concerne: Text[100];
        TicketPlanteur: Boolean;
        TicketTransporteur: Boolean;
        Nom_Concerne: Code[250];
        PrixAchat: Record "Prix Achat";
        TaxeImpot: Decimal;
        Titre: Text[50];
        visibleTransport: Boolean;
        visiblePlanteur: Boolean;
        CL: Code[50];

}