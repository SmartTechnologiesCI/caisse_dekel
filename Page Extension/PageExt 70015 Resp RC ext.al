// pageextension 70015 "resp comm RC" extends 50057
// {
//     layout
//     {

//     }

//     actions
//     {
//         addlast(Sections)
//         {
//             group("Performances commerciales")
//             {
//                 action(Groupe)
//                 {
//                     RunObject = page Teams;
//                 }
//                 action("Taches")
//                 {
//                     RunObject = Page 70080;
//                 }
//                 action("Performance")
//                 {
//                     Visible = false;
//                     RunObject = report 70020;
//                 }
//                 action("Performance new")
//                 {
//                     Caption = 'Etat performances pérodique';
//                     RunObject = report 70021;
//                 }
//                 action("Prime par commercial")
//                 {
//                     Caption = 'Prime par commercial';
//                     RunObject = report 70024;
//                 }
//                 action("Performance peseur")
//                 {
//                     //Visible = false;
//                     RunObject = report 70022;
//                 }
//             }


//         }
//         addfirst(Reporting)
//         {
//             action("Articles Vendus")
//             {
//                 Caption = 'Articles vendus';
//                 RunObject = report "Article vendu2";
//             }
//         }
//     }

//     var
//         myInt: Integer;
// }