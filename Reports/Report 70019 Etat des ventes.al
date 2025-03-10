report 70019 "Etat des ventes 2"
{
    
    //silue samuel 07/03/2025 RDLCLayout = 'Reports\RDLC\Report 70019 Etat des ventes.rdlc';
    // Caption = 'Etat des ventes';
    // UsageCategory = ReportsAndAnalysis;
    // ApplicationArea = All;

    // dataset
    // {
    //     dataitem(Cmde_Achat; "Purchase Header")
    //     {
    //         dataitem("LigneArticle"; 50012)
    //         {
    //             DataItemLink = "N° commande" = field("No.");

    //             column(Date_Debut; Date_Debut)
    //             {

    //             }
    //             column(Date_Fin; Date_Fin)
    //             {
    //             }
    //             column(N__article; "N° article")
    //             {
    //             }
    //             column(Description; Description)
    //             {
    //             }
    //             column("Qté_poids"; "Qté poids")
    //             {
    //             }
    //             column(Nombre_cartons; "Nombre cartons")
    //             {
    //             }
    //             column("Coût_Achat"; "Coût Achat")
    //             {
    //             }
    //             column("Coût_de_revient"; "Coût de revient")
    //             {
    //             }
    //             column("Coût_moyen"; Cout_moyen)
    //             {
    //             }
    //             column("Qté_vente"; "Qté vente")
    //             {
    //             }
    //             column(Prix_vente; "Prix vente")
    //             {
    //             }
    //             column(Total_Prix_vente; "Total Prix vente")
    //             {
    //             }
    //             column(Marge; Marge)
    //             {
    //             }
    //             trigger OnAfterGetRecord()
    //             var
    //                 // silue samuel 07/03/2025 salesLine: Record "Sales Invoice Line";
    //                 SaleInvoice: record "Sales Invoice Header";
    //                 tempCout: Decimal;
    //                 moyenCout: Decimal;
    //                 myInt: Integer;
    //             begin
    //                 //  silue samuel 07/03/2025salesLine.SetRange("No.", "N° article");
    //                 // // trouver le cout moyen en partant de la date du debut de l'annee 2021
    //                 // if salesLine.FindFirst() then begin

    //                 //     repeat
    //                 //         Cout_moyen := LigneArticle."Coût de revient";
    //                 //         tsalesLine.Reset();
    //                 // empCout := tempCout + Cout_moyen;
    //                 //         myInt := myInt + 1;

    //                 //     until LigneArticle.Next = 0;
    //                 //     moyenCout := tempCout / myInt;
    //                 //    fin silue samuel 07/03/2025 Cout_moyen := moyenCout;

    //                 // fin silue samuel 07/03/2025 end;



    //                 // silue samuel 07/03/2025 salesLine.Reset();// On reset pour recommencer les filtres
    //                 // salesLine.SetRange("Shipment Date", Date_Debut, Date_Fin);
    //                 // salesLine.SetRange("No.", "N° article");
    //                 // salesLine.SetFilter("Statut Livraison", '<>%1', salesLine."Statut Livraison"::"Non payée");
    //                 // "Qté vente" := 0;
    //                 // "Cartons vendus" := 0;
    //                 // "Prix vente" := 0;
    //                 // "Total Prix vente" := 0;
    //                 // if salesLine.FindFirst() then begin
    //                 //     repeat

    //                 //         "Qté vente" += salesLine.Quantity;
    //                 //         "Prix vente" := salesLine."Unit Price";
    //                 //         "Cartons vendus" += salesLine."Carton effectif";
    //                 //     until salesLine.next = 0;
    //                 //     "Total Prix vente" := salesLine."Unit Price" * "Qté vente";
    //                 // fin silue samuel 07/03/2025 end;
    //             end;

    //             trigger OnPreDataItem()
    //             var
    //                 myInt: Integer;
    //             begin
    //                 // silue samuel 07/03/2025 setRange("prix fixé", true);
    //             end;
    //         }
    //         trigger OnPreDataItem()
    //         var
    //             myInt: Integer;
    //         begin
    //             SetRange("Document Type", Cmde_Achat."Document Type"::Order);
    //             SetRange(ETA, Date_Debut, Date_Fin);
    //         end;
    //     }
    // }
    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group("Période")
    //             {
    //                 field(Date_Debut; Date_Debut)
    //                 {
    //                     Caption = 'Début de période';
    //                     ApplicationArea = All;
    //                 }
    //                 field(Date_Fin; Date_Fin)
    //                 {
    //                     Caption = 'Fin de période';
    //                     ApplicationArea = All;
    //                 }
    //             }
    //         }
    //     }
    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {
    //                 ApplicationArea = All;
    //             }
    //         }
    //     }


    //     trigger OnOpenPage()
    //     var
    //         myInt: Integer;
    //         // silue samuel 07/03/2025 salesLine: Record "Sales Invoice Line";
    //         article: Record 50012;


    //     begin
    //         //  silue samuel 07/03/2025 Date_Debut_Cout_moyen := DMY2Date(01, 01, Date2DMY(WorkDate(), 3));
    //         // salesLine.SetRange("No.", article."N° article");
    //         // fin silue samuel 07/03/2025 salesLine.SetRange("Shipment Date", Date_Debut_Cout_moyen, Date_Fin);





    //     end;
    //fin silue samuel 07/03/2025 }

    var
        "Qté vente": Decimal;
        "Prix vente": Decimal;
        "Total Prix vente": Decimal;
        "Marge": Decimal;
        "Cartons vendus": Decimal;
        Date_Debut: Date;
        Date_Fin: Date;
        Date_Debut_Cout_moyen: Date;
        Cout_moyen: Decimal;
}