report 70049 Client_Fournisseur
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Rapport Quotidien Client Fournisseur';
    RDLCLayout = 'Reports\RDLC\Report Client_Fournisser.rdlc';

    dataset
    {
        dataitem("Item Weigh Bridge"; "Item Weigh Bridge")
        {
            RequestFilterFields = "Nom Client", "Type opération", "Date validation";
            column(Vehicle_Registration_No_; "Vehicle Registration No.")
            {

            }
            column(Date_validation; "Date validation")
            {

            }
            column(Weighing_2_Hour; "Weighing 2 Hour")
            {

            }
            column(Ticket_Planteur; "Ticket Planteur")
            {

            }
            column(POIDS_ENTREE; "POIDS ENTREE")
            {

            }
            column(POIDS_SORTIE; "POIDS SORTIE")
            {

            }
            column(POIDS_NET; "POIDS NET")
            {

            }
            column(Nom_Client; "Nom Client")
            {

            }
            column("Type_opération"; "Type opération")
            {

            }
            column(Filter; Filter)
            {

            }
            column(Centre_Logistique; "Centre Logistique")
            {
                //Considéré
            }
            column("Désignation_article"; "Désignation article")
            {

            }
            column(ValeurTypeOperation; ValeurTypeOperation)
            {

            }
            column(PeriodeImpression; PeriodeImpression)
            {

            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                // if ((CopyStr(GetFilters, StrPos(GetFilters, ':') + 2)) <> (GetFilter("Date validation"))) then begin
                //     Filter := CopyStr(GetFilters, StrPos(GetFilters, ':') + 2);
                //     Message(Filter);
                // end;
                // if TypeOperation = true then begin
                //     // Filter := "Nom Client"
                //     Message('Filter: %1', "Nom Client")
                // end else
                //     if Produit = true then begin
                //         Filter := "Désignation article";
                //         Message('Filter: %1', Filter);
                //     end;
                PeriodeImpression := CopyStr(GetFilters, StrPos(GetFilters, ':') + 2);


            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                if TypeOperation = true then begin
                    Filter := "Type opération";
                    ValeurTypeOperation := 'TYPE OPERATION'
                    // Message('FilterProduit: %1', "Nom Client")
                end else
                    if Produit = true then begin
                        Filter := "Désignation article";
                        ValeurTypeOperation := 'PRODUIT'
                        // Message('FilterProduit: %1', Filter);
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
                group(GroupName)
                {
                    field(TypeOperation; TypeOperation)
                    {
                        Caption = 'Type Opération';
                        ApplicationArea = All;

                    }
                    field(Produit; Produit)
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
        Filter: Text[50];
        TypeOperation: Boolean;
        Produit: Boolean;
        ValeurTypeOperation: code[100];
        PeriodeImpression: Text[250];
}