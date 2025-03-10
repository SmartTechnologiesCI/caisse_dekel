report 70013 "Conteneurs vendu"
{
    // silue samuel 07/03/2025 ApplicationArea = All;
    // UsageCategory = ReportsAndAnalysis;
    // PreviewMode = PrintLayout;
    // //DataAccessIntent = ReadOnly;
    // RDLCLayout = 'Reports\RDLC\Report 70013 Etat conteneur vendu.rdlc';

    // dataset
    // {
    //     dataitem("Ligne Artcile prix"; "Ligne Artcile prix")
    //     {



    //         column(dateDebut; dateDebut) { }
    //         column(dateFin; dateFin) { }
    //         column(N__commande; "N° commande")
    //         {

    //         }
    //         column("Prix_fixé"; "Prix fixé") { }
    //         column(fournisseur; Fournisseur)
    //         {

    //         }
    //         column(dateEta; dateEta) { }
    //         column(dateCommande; dateCommande) { }
    //         column(Date_mise_en_vente; "Date mise en vente") { }
    //         column(Description; Description) { }

    //         trigger OnPreDataItem()
    //         var
    //             myInt: Integer;




    //         begin
    //             /*
    //             TODO: Desactiver cette ligne pour mettre a jour la date de mise en vente. Apres la mise a jour reactiver cette ligne
                
    //             */

    //             SetRange("Date mise en vente", dateDebut, dateFin);
    //             if (Format(dateDebut) = '') and (Format(dateFin) = '') then begin
    //                 Error('Une date est requise');
    //             end;


    //         end;

    //         trigger OnAfterGetRecord()
    //         var
    //             myInt: Integer;
    //             purchaseHeader: Record "Purchase Header";

    //         begin

    //             purchaseHeader.SetRange("No.", "N° commande");
    //             if purchaseHeader.FindFirst() then begin
    //                 repeat
    //                     dateEta := purchaseHeader.ETA;
    //                     fournisseur := purchaseHeader."Buy-from Vendor Name";
    //                     dateCommande := purchaseHeader."Order Date";

    //                     if (Format("Date mise en vente") = '') or ("Date mise en vente" = 0D) then begin
    //                         "Date mise en vente" := dateEta;
    //                         Modify();

    //                     end;


    //                 until purchaseHeader.Next = 0;
    //             end;


    //             // Message(Format(purchaseHeader));

    //         end;

    //         trigger OnPostDataItem()
    //         var
    //             myInt: Integer;
    //         begin
    //             SetRange("Date mise en vente", dateDebut, dateFin);
    //         end;



    //     }

    // }



    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(DateMiseEnVente)
    //             {
    //                 Caption = 'Date de mise en vente';
    //                 /*    field
    //                 (Name; SourceExpression)
    //                    {
    //                        ApplicationArea = All;

    //                    } */



    //                 field(dateDebut; dateDebut)
    //                 {
    //                     Caption = 'Du :';
    //                 }
    //                 field(dateFin; dateFin)
    //                 {
    //                     Caption = 'au';
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
    //     begin
    //         dateDebut := WorkDate();
    //         dateFin := WorkDate();
    //     end;
    // }

    // var
    //     myInt: Integer;
    //     dateDebut: Date;
    //     dateFin: Date;
    //     dateEta: Date;
    //     fournisseur: Text[100];
    //     dateCommande: Date;

}