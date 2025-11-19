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
            RequestFilterFields = "Ticket Planteur";
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

            trigger OnPreDataItem()
            var
            begin
                CompanyInfo.get();
                CompanyInfo.CalcFields(Picture);
                if TicketPlanteur = false and TicketTransporteur = false then begin
                    Error('Choisissez le type de ticket (Soit Planteur soit Transporteur)');
                end else begin
                    if TicketPlanteur = true and TicketTransporteur = true then begin
                        Error('Choisissez un seul ticket');
                    end;
                    if TicketPlanteur = true then begin
                        Concerne := Planteur;
                    end;
                    if TicketTransporteur = true then begin
                        Concerne := Transporteurname;
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
                    field(Planteur; Planteur)
                    {
                        ApplicationArea = All;
                    }
                    field(Transporteurname; Transporteurname)
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
}