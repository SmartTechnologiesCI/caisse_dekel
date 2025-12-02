report 70048 Recu_Paiement
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Reçu Paiement';
    RDLCLayout = 'Reports\RDLC\Report 70048 Recu Paiement.rdlc';
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

            trigger OnPreDataItem()
            var
                TypeOperation: Option;
            begin

                CompanyInfo.get();
                CompanyInfo.CalcFields(Picture);
                if ((TicketPlanteur = false) and (TicketTransporteur = false)) then begin
                    Error('Choisissez le type de ticket (Soit Planteur soit Transporteur)');
                end else begin
                    if ((TicketPlanteur = true) and (TicketTransporteur = true)) then begin
                        Error('Choisissez un seul ticket');
                    end;
                    if TicketPlanteur = true then begin
                        Concerne := Planteur;
                        Nom_Concerne := "Nom planteur";
                        if PrixAchat.FindSet() then begin

                        end;
                        // PrixAchat.SetRange("Type operation", "Type opération");
                    end else begin
                        if TicketTransporteur = true then begin
                            Concerne := Transporteurname;
                            Nom_Concerne := "Nom Transporteur";
                        end;
                    end;
                end;
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                if TicketPlanteur = true then begin
                    Nom_Concerne := "Nom planteur";
                    PrixAchat.setFilter("Purchase Type", '=%1', PrixAchat."Purchase Type"::"Vendor Posting Group");
                    PrixAchat.SetFilter("Item No.", '=%1', 'RPH-9003');
                    PrixAchat.SetFilter("Starting Date", '<=%1', "Weighing 1 Date");
                    PrixAchat.SetFilter("Ending Date", '>=%1', "Weighing 1 Date");
                    PrixAchat.SetRange(Type_Operation_Options, "Type opération");
                    if PrixAchat.FindFirst() then begin
                        Prix := PrixAchat."Direct Unit Cost";
                    end;
                end else begin
                    if TicketTransporteur = true then begin
                        Nom_Concerne := "Driver Name";
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
                    }
                    field(TicketTransporteur; TicketTransporteur)
                    {
                        ApplicationArea = All;
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

}