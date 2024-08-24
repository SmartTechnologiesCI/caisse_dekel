report 70006 "Control par article"
{
    RDLCLayout = 'Reports\RDLC\Report 70006 Control livraison par article.rdlc';
    Caption = 'Etat control de livraison';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Controle Livraison"; "Controle Livraison")
        {

            RequestFilterFields = "Statut Livraison";
            column(Date_Debut; Date_Debut)
            {

            }
            column(Date_fin; Date_fin)
            {

            }
            column(Document_No_; "No facture")
            {

            }
            column(Item_No_; "No article")
            {

            }
            column(Description; SalesIvoiceLine.Description)
            {

            }
            column(Nombre_de_carton; SalesIvoiceLine."Carton effectif")
            {

            }
            column("Cartons_livrée"; "Qté livrée")
            {

            }
            /*   column(reste; reste)
              {

              }  */
            column(reste; SalesIvoiceLine."Carton effectif" - "Qté livrée")
            {

            }
            column(Statut_Livraison_Line; "Statut Livraison")
            {

            }
            column("Qté_livrée"; "Qté livrée") { }
            column(Date_Livraison; "Date Livraison") { }

            column(livraisonRecente; livraisonRecente) { }
            column("Qté_livrée_Auj"; SalesIvoiceLine."Qté livrée auj") { }


            trigger OnPreDataItem()
            var

            begin
                "Controle Livraison".SetRange("Date Livraison", Date_Debut, Date_Fin);
                /*   SalesIvoiceLine.SetFilter(datefilter, '=%1', WorkDate());
                  SalesIvoiceLine.CalcFields("Qté livrée auj"); */



            end;


            trigger OnAfterGetRecord()
            var
            //SalesInvoiceLine: Record "Sales Invoice Line";



            begin
                //"Sales Invoice Line".Reset();
                //"Sales Invoice Line".SetRange();
                SalesIvoiceLine.Reset();
                SalesIvoiceLine.SetFilter("No.", "No article");
                SalesIvoiceLine.SetFilter("Document No.", "No facture");
                //"Controle Livraison".SETFILTER(dateFilter, '=%1', WorkDate());
                //SalesIvoiceLine.SETFILTER(dateFilter, '=%1', WorkDate());
                SalesIvoiceLine.FindSet();

                if "Controle Livraison"."Date Livraison" = WorkDate() then begin
                    livraisonRecente := "Qté livrée";
                end;






                //livraisonRecente := "Qté livrée" + "Qté livrée";

                /* "Sales Invoice Line".setRange("Posting Date",WorkDate());
                 if "Sales Invoice Line"."Statut Livraison"= "Sales Invoice Line"."Statut Livraison"::"Payée totalement livré" then begin

                 end; */


            end;




        }
    }



    requestpage
    {
        layout
        {
            area(Content)
            {
                field(Date_Debut; Date_Debut)
                {

                }
                field(Date_fin; Date_fin)
                {

                }
            }
        }
        trigger OnOpenPage()
        var
            myInt: Integer;
        begin
            Date_Debut := WorkDate();
            Date_fin := WorkDate();
            //"Controle Livraison".SETFILTER(dateFilter, '=%1', WorkDate());
            //SalesIvoiceLine.SETFILTER(dateFilter, '=%1', WorkDate());
        end;
    }

    var
        reste: Integer;
        Date_Debut: Date;
        Date_fin: Date;
        livraisonRecente: Decimal;
        SalesIvoiceLine: Record "Sales Invoice Line";
        controleLivraison: Record "Controle Livraison";


}